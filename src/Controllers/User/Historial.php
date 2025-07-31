<?php

namespace Controllers\User;

use Controllers\PrivateController;
use Dao\Transacciones\Transacciones;
use Utilities\Security;
use Utilities\Site;
use Views\Renderer;

class Historial extends PrivateController
{
    public function run(): void
    {
        Site::addLink("public/css/historial.css");
        
        $userId = Security::getUserId();
        $transacciones = Transacciones::getTransaccionesByUser($userId);
        
        
        $historialFormateado = [];
        $totalGeneral = 0;
        
        foreach ($transacciones as $transaccion) {
            $detalles = Transacciones::getDetallesTransaccion($transaccion['transaccionId']);
            $subtotal = 0;
            
            foreach ($detalles as $detalle) {
                $subtotal += $detalle['precio'] * $detalle['cantidad'];
            }
            
            $historialFormateado[] = [
                'transaccionId' => $transaccion['transaccionId'],
                'fecha' => date('d/m/Y H:i', strtotime($transaccion['fechaTransaccion'])),
                'estado' => $transaccion['estado'],
                'metodoPago' => $transaccion['metodoPago'],
                'subtotal' => number_format($subtotal, 2),
                'detalles' => $detalles
            ];
            
            $totalGeneral += $subtotal;
        }
        
        $viewData = [
            'historial' => $historialFormateado,
            'totalGeneral' => number_format($totalGeneral, 2),
            'totalTransacciones' => count($historialFormateado),
            'usuario' => Security::getUserName()
        ];
        
        Renderer::render("user/historial", $viewData);
    }
}