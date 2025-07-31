<?php

namespace Dao\Transacciones;

class Transacciones extends \Dao\Table
{
    public static function getTransaccionesByUser($userId)
    {
        $sql = "SELECT t.*, u.nombre as nombreUsuario 
                FROM transacciones t 
                INNER JOIN usuarios u ON t.userId = u.userId 
                WHERE t.userId = :userId 
                ORDER BY t.fechaTransaccion DESC";
        
        return self::obtenerRegistros($sql, ['userId' => $userId]);
    }
    
    public static function getAllTransacciones($filtros = [])
    {
        $sql = "SELECT t.*, u.nombre as nombreUsuario 
                FROM transacciones t 
                INNER JOIN usuarios u ON t.userId = u.userId 
                WHERE 1=1";
        
        $params = [];
        
        if (!empty($filtros['fechaInicio'])) {
            $sql .= " AND DATE(t.fechaTransaccion) >= :fechaInicio";
            $params['fechaInicio'] = $filtros['fechaInicio'];
        }
        
        if (!empty($filtros['fechaFin'])) {
            $sql .= " AND DATE(t.fechaTransaccion) <= :fechaFin";
            $params['fechaFin'] = $filtros['fechaFin'];
        }
        
        if (!empty($filtros['estado'])) {
            $sql .= " AND t.estado = :estado";
            $params['estado'] = $filtros['estado'];
        }
        
        if (!empty($filtros['metodoPago'])) {
            $sql .= " AND t.metodoPago = :metodoPago";
            $params['metodoPago'] = $filtros['metodoPago'];
        }
        
        $sql .= " ORDER BY t.fechaTransaccion DESC";
        
        return self::obtenerRegistros($sql, $params);
    }
    
    public static function getDetallesTransaccion($transaccionId)
    {
        $sql = "SELECT dt.*, p.productName as nombreLibro 
                FROM detalle_transacciones dt 
                INNER JOIN products p ON dt.productId = p.productId 
                WHERE dt.transaccionId = :transaccionId";
        
        return self::obtenerRegistros($sql, ['transaccionId' => $transaccionId]);
    }
    
    public static function getEstadisticas()
    {
        $sql = "SELECT 
                    COUNT(*) as totalTransacciones,
                    SUM(CASE WHEN estado = 'completada' THEN 1 ELSE 0 END) as transaccionesCompletadas,
                    SUM(CASE WHEN estado = 'pendiente' THEN 1 ELSE 0 END) as transaccionesPendientes,
                    SUM(CASE WHEN estado = 'cancelada' THEN 1 ELSE 0 END) as transaccionesCanceladas,
                    AVG((SELECT SUM(precio * cantidad) FROM detalle_transacciones dt WHERE dt.transaccionId = t.transaccionId)) as promedioVenta
                FROM transacciones t";
        
        $resultado = self::obtenerUnRegistro($sql, []);
        
        
        $sqlVentasMes = "SELECT 
                            DATE_FORMAT(fechaTransaccion, '%Y-%m') as mes,
                            COUNT(*) as cantidadTransacciones,
                            SUM((SELECT SUM(precio * cantidad) FROM detalle_transacciones dt WHERE dt.transaccionId = t.transaccionId)) as totalVentas
                         FROM transacciones t 
                         WHERE fechaTransaccion >= DATE_SUB(NOW(), INTERVAL 12 MONTH)
                         AND estado = 'completada'
                         GROUP BY DATE_FORMAT(fechaTransaccion, '%Y-%m')
                         ORDER BY mes DESC";
        
        $ventasMensuales = self::obtenerRegistros($sqlVentasMes, []);
        
        $resultado['ventasMensuales'] = $ventasMensuales;
        $resultado['promedioVenta'] = number_format($resultado['promedioVenta'] ?? 0, 2);
        
        return $resultado;
    }
    
    public static function getEstadisticasByUser($userId)
    {
        $sql = "SELECT 
                    COUNT(*) as totalCompras,
                    SUM((SELECT SUM(precio * cantidad) FROM detalle_transacciones dt WHERE dt.transaccionId = t.transaccionId)) as montoTotal,
                    MAX(fechaTransaccion) as ultimaCompra
                FROM transacciones t 
                WHERE userId = :userId AND estado = 'completada'";
        
        return self::obtenerUnRegistro($sql, ['userId' => $userId]);
    }
    
    public static function crearTransaccion($userId, $metodoPago, $estado = 'pendiente')
    {
        $sql = "INSERT INTO transacciones (userId, metodoPago, estado, fechaTransaccion) 
                VALUES (:userId, :metodoPago, :estado, NOW())";
        
        $params = [
            'userId' => $userId,
            'metodoPago' => $metodoPago,
            'estado' => $estado
        ];
        
        return self::executeNonQuery($sql, $params);
    }
    
    public static function agregarDetalleTransaccion($transaccionId, $productId, $cantidad, $precio)
    {
        $sql = "INSERT INTO detalle_transacciones (transaccionId, productId, cantidad, precio) 
                VALUES (:transaccionId, :productId, :cantidad, :precio)";
        
        $params = [
            'transaccionId' => $transaccionId,
            'productId' => $productId,
            'cantidad' => $cantidad,
            'precio' => $precio
        ];
        
        return self::executeNonQuery($sql, $params);
    }
    
    public static function actualizarEstadoTransaccion($transaccionId, $estado)
    {
        $sql = "UPDATE transacciones SET estado = :estado WHERE transaccionId = :transaccionId";
        
        return self::executeNonQuery($sql, [
            'transaccionId' => $transaccionId,
            'estado' => $estado
        ]);
    }
}