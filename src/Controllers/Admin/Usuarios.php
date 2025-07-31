<?php

namespace Controllers\Admin;

use Controllers\PrivateController;
use Dao\Users\Users;
use Dao\Transacciones\Transacciones;
use Utilities\Site;
use Views\Renderer;

class Usuarios extends PrivateController
{
    public function run(): void
    {
        Site::addLink("public/css/admin.css");
        
        
        $usuarios = Users::getAllUsers();
        
        
        $usuariosConEstadisticas = [];
        foreach ($usuarios as $usuario) {
            $estadisticasUsuario = Transacciones::getEstadisticasByUser($usuario['userId']);
            
            $usuariosConEstadisticas[] = [
                'userId' => $usuario['userId'],
                'nombre' => $usuario['nombre'],
                'email' => $usuario['email'],
                'fechaRegistro' => date('d/m/Y', strtotime($usuario['fechaRegistro'])),
                'estado' => $usuario['estado'],
                'totalCompras' => $estadisticasUsuario['totalCompras'] ?? 0,
                'montoTotal' => number_format($estadisticasUsuario['montoTotal'] ?? 0, 2),
                'ultimaCompra' => $estadisticasUsuario['ultimaCompra'] ? 
                    date('d/m/Y', strtotime($estadisticasUsuario['ultimaCompra'])) : 'Nunca'
            ];
        }
        
        
        $estadisticasGenerales = Users::getEstadisticasGenerales();
        
        $viewData = [
            'usuarios' => $usuariosConEstadisticas,
            'estadisticasGenerales' => $estadisticasGenerales,
            'totalUsuarios' => count($usuariosConEstadisticas)
        ];
        
        Renderer::render("admin/usuarios", $viewData);
    }
}