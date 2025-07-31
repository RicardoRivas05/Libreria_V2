<?php

namespace Dao\Users;

class Users extends \Dao\Table
{
    public static function getAllUsers()
    {
        $sql = "SELECT userId, nombre, email, fechaRegistro, estado 
                FROM usuarios 
                ORDER BY fechaRegistro DESC";
        
        return self::obtenerRegistros($sql, []);
    }
    
    public static function getUserById($userId)
    {
        $sql = "SELECT * FROM usuarios WHERE userId = :userId";
        
        return self::obtenerUnRegistro($sql, ['userId' => $userId]);
    }
    
    public static function getEstadisticasGenerales()
    {
        $sql = "SELECT 
                    COUNT(*) as totalUsuarios,
                    SUM(CASE WHEN estado = 'activo' THEN 1 ELSE 0 END) as usuariosActivos,
                    SUM(CASE WHEN estado = 'inactivo' THEN 1 ELSE 0 END) as usuariosInactivos,
                    COUNT(CASE WHEN DATE(fechaRegistro) = CURDATE() THEN 1 END) as registrosHoy,
                    COUNT(CASE WHEN fechaRegistro >= DATE_SUB(NOW(), INTERVAL 7 DAY) THEN 1 END) as registrosUltimaSemana,
                    COUNT(CASE WHEN fechaRegistro >= DATE_SUB(NOW(), INTERVAL 30 DAY) THEN 1 END) as registrosUltimoMes
                FROM usuarios";
        
        $resultado = self::obtenerUnRegistro($sql, []);
        
        
        $sqlRegistrosMes = "SELECT 
                               DATE_FORMAT(fechaRegistro, '%Y-%m') as mes,
                               COUNT(*) as cantidadRegistros
                            FROM usuarios 
                            WHERE fechaRegistro >= DATE_SUB(NOW(), INTERVAL 12 MONTH)
                            GROUP BY DATE_FORMAT(fechaRegistro, '%Y-%m')
                            ORDER BY mes DESC";
        
        $registrosMensuales = self::obtenerRegistros($sqlRegistrosMes, []);
        
        $resultado['registrosMensuales'] = $registrosMensuales;
        
        return $resultado;
    }
    
    public static function actualizarEstadoUsuario($userId, $estado)
    {
        $sql = "UPDATE usuarios SET estado = :estado WHERE userId = :userId";
        
        return self::executeNonQuery($sql, [
            'userId' => $userId,
            'estado' => $estado
        ]);
    }
    
    public static function buscarUsuarios($termino)
    {
        $sql = "SELECT userId, nombre, email, fechaRegistro, estado 
                FROM usuarios 
                WHERE nombre LIKE :termino OR email LIKE :termino
                ORDER BY nombre ASC";
        
        return self::obtenerRegistros($sql, ['termino' => "%{$termino}%"]);
    }
}