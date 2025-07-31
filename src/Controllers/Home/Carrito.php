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

        // Inicializar carrito en sesión si no existe
        if (!isset($_SESSION['carrito'])) {
            $_SESSION['carrito'] = [];
        }

        // Procesar acciones del carrito
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $this->procesarAccion();
        }

        // Calcular totales y preparar datos del carrito
        $subtotal = 0;
        $totalItems = 0;
        $carritoConSubtotales = [];

        foreach ($_SESSION['carrito'] as $codLibro => $item) {
            if (!isset($item['codLibro'], $item['nombre'], $item['precio'], $item['cantidad'])) {
                continue;
            }

            $precio = floatval($item['precio']);
            $cantidad = intval($item['cantidad']);
            $itemSubtotal = $precio * $cantidad;

            $subtotal += $itemSubtotal;
            $totalItems += $cantidad;

            $carritoConSubtotales[] = [
                'codLibro' => $item['codLibro'],
                'nombre' => $item['nombre'],
                'precio' => number_format($precio, 2),
                'cantidad' => $cantidad,
                'subtotal' => number_format($itemSubtotal, 2)
            ];
        }

        $impuesto = $subtotal * 0.15;
        $total = $subtotal + $impuesto;
        $totalUSD = $total / 24.5; // Tasa de conversión estimada, ajusta si es necesario

        $viewData = [
            "SITE_TITLE" => "Carrito de Compras - Biblioteca Virtual",
            "BASE_DIR" => Context::getContextByKey("BASE_DIR"),
            "usuario" => $_SESSION["userName"] ?? "Invitado",
            "carrito" => $carritoConSubtotales,
            "subtotal" => number_format($subtotal, 2),
            "impuesto" => number_format($impuesto, 2),
            "total" => number_format($total, 2),
            "totalUSD" => number_format($totalUSD, 2, '.', ''), // PayPal requiere string con punto decimal
            "totalItems" => $totalItems,
            "carritoVacio" => empty($carritoConSubtotales),
            "mensaje" => $_SESSION['mensaje_carrito'] ?? "",
            "USE_URLREWRITE" => "0",
            "PAYPAL_CLIENT_ID" => Context::getEnv("PAYPAL_CLIENT_ID")
        ];

        unset($_SESSION['mensaje_carrito']);
        Renderer::render("home/carrito", $viewData);
    }

    private function procesarAccion(): void
    {
        $accion = $_POST['accion'] ?? '';
        $codLibro = $_POST['codLibro'] ?? '';

        switch ($accion) {
            case 'agregar':
                $this->agregarAlCarrito();
                break;
            case 'eliminar':
                $this->eliminarDelCarrito($codLibro);
                break;
            case 'actualizar':
                $this->actualizarCantidad($codLibro);
                break;
            case 'vaciar':
                $this->vaciarCarrito();
                break;
        }
    }

    private function agregarAlCarrito(): void
    {
        if (!isset($_POST['codLibro'], $_POST['nombre'], $_POST['precio'], $_POST['cantidad'])) {
            return;
        }

        $codLibro = $_POST['codLibro'];
        $nombre = $_POST['nombre'];
        $precio = floatval($_POST['precio']);
        $cantidad = intval($_POST['cantidad']);

        if (isset($_SESSION['carrito'][$codLibro])) {
            $_SESSION['carrito'][$codLibro]['cantidad'] += $cantidad;
        } else {
            $_SESSION['carrito'][$codLibro] = [
                'codLibro' => $codLibro,
                'nombre' => $nombre,
                'precio' => $precio,
                'cantidad' => $cantidad
            ];
        }

        $_SESSION['mensaje_carrito'] = "Libro agregado al carrito";
    }

    private function eliminarDelCarrito(string $codLibro): void
    {
        if (isset($_SESSION['carrito'][$codLibro])) {
            unset($_SESSION['carrito'][$codLibro]);
            $_SESSION['mensaje_carrito'] = "Libro eliminado del carrito";
        }
    }

    private function actualizarCantidad(string $codLibro): void
    {
        if (!isset($_POST['cantidad']) || !isset($_SESSION['carrito'][$codLibro])) {
            return;
        }

        $nuevaCantidad = intval($_POST['cantidad']);
        if ($nuevaCantidad > 0) {
            $_SESSION['carrito'][$codLibro]['cantidad'] = $nuevaCantidad;
            $_SESSION['mensaje_carrito'] = "Cantidad actualizada";
        } else {
            $this->eliminarDelCarrito($codLibro);
        }
    }

    private function vaciarCarrito(): void
    {
        $_SESSION['carrito'] = [];
        $_SESSION['mensaje_carrito'] = "Carrito vaciado correctamente.";
    }
}
