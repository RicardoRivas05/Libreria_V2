<?php

namespace Controllers\Admin;

use Controllers\PrivateController;
use Dao\Transacciones\Transacciones as TransaccionesDao;
use Utilities\Site;
use Views\Renderer;

class Transacciones extends PrivateController
{
    public function run(): void
    {
        Site::addLink("public/css/admin.css");


        $filtros = [
            'fechaInicio' => $_GET['fechaInicio'] ?? null,
            'fechaFin' => $_GET['fechaFin'] ?? null,
            'estado' => $_GET['estado'] ?? null,
            'metodoPago' => $_GET['metodoPago'] ?? null
        ];

        $transacciones = TransaccionesDao::getAllTransacciones($filtros);


        $estadisticas = TransaccionesDao::getEstadisticas();


        $transaccionesFormateadas = [];
        foreach ($transacciones as $transaccion) {
            $detalles = TransaccionesDao::getDetallesTransaccion($transaccion['transaccionId']);
            $total = 0;
            $cantidadLibros = 0;

            foreach ($detalles as $detalle) {
                $total += $detalle['precio'] * $detalle['cantidad'];
                $cantidadLibros += $detalle['cantidad'];
            }

            $transaccionesFormateadas[] = [
                'transaccionId' => $transaccion['transaccionId'],
                'usuario' => $transaccion['nombreUsuario'],
                'fecha' => date('d/m/Y H:i', strtotime($transaccion['fechaTransaccion'])),
                'estado' => $transaccion['estado'],
                'metodoPago' => $transaccion['metodoPago'],
                'total' => number_format($total, 2),
                'cantidadLibros' => $cantidadLibros,
                'detalles' => $detalles
            ];
        }

        $viewData = [
            'transacciones' => $transaccionesFormateadas,
            'estadisticas' => $estadisticas,
            'filtros' => $filtros,
            'totalTransacciones' => count($transaccionesFormateadas)
        ];

        Renderer::render("admin/transacciones", $viewData);
    }
}
