<?php
namespace Controllers\Home;

use Controllers\PublicController;
use Views\Renderer;
use Utilities\Context;

class Carrito extends PublicController
{
    public function run(): void
    {
        error_reporting(E_ALL);
        ini_set('display_errors', 1);
        
        // Inicializar carrito si no existe
        if (!isset($_SESSION['carrito'])) {
            $_SESSION['carrito'] = [];
        }
        
        // Procesar acciones del carrito
        $this->procesarAccion();
        
        // Preparar datos para la vista
        $viewData = [
            "SITE_TITLE" => "Carrito de Compras - Biblioteca Virtual",
            "BASE_DIR" => Context::getContextByKey("BASE_DIR"),
            "FONT_AWESOME_KIT" => "", 
            "CURRENT_YEAR" => date("Y"),
            "PUBLIC_DEFAULT_CONTROLLER" => "Home",
            "PUBLIC_NAVIGATION" => [
                ["nav_url" => "index.php?page=Home", "nav_label" => "Inicio"],
                ["nav_url" => "index.php?page=Catalogo", "nav_label" => "Catálogo"],
                ["nav_url" => "index.php?page=Home_Carrito", "nav_label" => "Carrito"],
                ["nav_url" => "index.php?page=Home_Login", "nav_label" => "Iniciar Sesión"]
            ],
            "usuario" => $_SESSION["userName"] ?? "Invitado",
            "carrito" => $_SESSION['carrito'],
            "total" => $this->calcularTotal(),
            "cantidad_items" => $this->contarItems(),
            "USE_URLREWRITE" => "0"
        ];

        Renderer::render("home/carrito", $viewData);
    }
    
    private function procesarAccion(): void
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $accion = $_POST['accion'] ?? 'agregar';
            
            switch ($accion) {
                case 'agregar':
                    $this->agregarAlCarrito();
                    break;
                case 'actualizar':
                    $this->actualizarCantidad();
                    break;
                case 'eliminar':
                    $this->eliminarDelCarrito();
                    break;
                case 'vaciar':
                    $this->vaciarCarrito();
                    break;
            }
        }
    }
    
    private function agregarAlCarrito(): void
    {
        if (isset($_POST['codLibro'], $_POST['nombre'], $_POST['precio'])) {
            $codLibro = $_POST['codLibro'];
            $nombre = $_POST['nombre'];
            $precio = floatval($_POST['precio']);
            $cantidad = intval($_POST['cantidad'] ?? 1);
            
            // Si el libro ya está en el carrito, aumentar la cantidad
            if (isset($_SESSION['carrito'][$codLibro])) {
                $_SESSION['carrito'][$codLibro]['cantidad'] += $cantidad;
            } else {
                // Agregar nuevo libro al carrito
                $_SESSION['carrito'][$codLibro] = [
                    'codLibro' => $codLibro,
                    'nombre' => $nombre,
                    'precio' => $precio,
                    'cantidad' => $cantidad
                ];
            }
            
            // Redireccionar para evitar reenvío del formulario
            header("Location: index.php?page=Home_Carrito&mensaje=agregado");
            exit;
        }
    }
    
    private function actualizarCantidad(): void
    {
        if (isset($_POST['codLibro'], $_POST['cantidad'])) {
            $codLibro = $_POST['codLibro'];
            $cantidad = intval($_POST['cantidad']);
            
            if ($cantidad > 0 && isset($_SESSION['carrito'][$codLibro])) {
                $_SESSION['carrito'][$codLibro]['cantidad'] = $cantidad;
            } elseif ($cantidad <= 0) {
                unset($_SESSION['carrito'][$codLibro]);
            }
            
            header("Location: index.php?page=Home_Carrito");
            exit;
        }
    }
    
    private function eliminarDelCarrito(): void
    {
        if (isset($_POST['codLibro'])) {
            $codLibro = $_POST['codLibro'];
            unset($_SESSION['carrito'][$codLibro]);
            
            header("Location: index.php?page=Home_Carrito&mensaje=eliminado");
            exit;
        }
    }
    
    private function vaciarCarrito(): void
    {
        $_SESSION['carrito'] = [];
        header("Location: index.php?page=Home_Carrito&mensaje=vaciado");
        exit;
    }
    
    private function calcularTotal(): float
    {
        $total = 0;
        foreach ($_SESSION['carrito'] as $item) {
            $total += $item['precio'] * $item['cantidad'];
        }
        return $total;
    }
    
    private function contarItems(): int
    {
        $count = 0;
        foreach ($_SESSION['carrito'] as $item) {
            $count += $item['cantidad'];
        }
        return $count;
    }
}