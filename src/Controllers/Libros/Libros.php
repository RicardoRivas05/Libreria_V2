<?php
namespace Controllers\Libros;

use Controllers\PublicController;
use Dao\Libros\Libros as LibrosDao;
use Views\Renderer;
use Utilities\Site;

class LibrosFixed extends PublicController
{
    public function run(): void
    {
        try {
            Site::addLink("public/css/libros.css");
            
            
            error_log("LibrosFixed: Iniciando controlador");
            
            
            $autor = $this->limpiarTexto($_GET["autor"] ?? "");
            $genero = $this->limpiarTexto($_GET["genero"] ?? "");
            $min = $this->validarPrecio($_GET["min"] ?? 0);
            $max = $this->validarPrecio($_GET["max"] ?? 9999);
            $busqueda = $this->limpiarTexto($_GET["busqueda"] ?? "");

            
            if ($min > $max) {
                $temp = $min;
                $min = $max;
                $max = $temp;
            }

            
            error_log("Parámetros - Autor: $autor, Género: $genero, Min: $min, Max: $max, Búsqueda: $busqueda");

            
            try {
                $libros = !empty($busqueda) 
                    ? LibrosDao::buscarPorTexto($busqueda) 
                    : LibrosDao::obtenerPorFiltro($autor, $genero, $min, $max);
                
                error_log("Libros obtenidos: " . count($libros));
                
            } catch (\Exception $dbError) {
                error_log("Error de BD: " . $dbError->getMessage());
                
                $libros = $this->getDatosPrueba();
            }

           
            try {
                $autoresDisponibles = LibrosDao::obtenerAutores();
                $generosDisponibles = LibrosDao::obtenerGeneros();
                $rangoPrecio = LibrosDao::obtenerRangoPrecios();
            } catch (\Exception $e) {
                error_log("Error obteniendo filtros: " . $e->getMessage());
                $autoresDisponibles = [['autor' => 'Paulo Coelho'], ['autor' => 'George Orwell']];
                $generosDisponibles = [['genero' => 'Ficción'], ['genero' => 'Distopía']];
                $rangoPrecio = ['min_precio' => 0, 'max_precio' => 9999];
            }

            
            $viewData = [
                'libros' => $this->formatearLibros($libros),
                'autor' => $autor,
                'genero' => $genero,
                'min' => $min,
                'max' => $max,
                'busqueda' => $busqueda,
                'total' => count($libros),
                'hayFiltros' => !empty($autor) || !empty($genero) || $min > 0 || $max < 9999 || !empty($busqueda),
                'autoresDisponibles' => $autoresDisponibles,
                'generosDisponibles' => $generosDisponibles,
                'precioMinimo' => $rangoPrecio['min_precio'] ?? 0,
                'precioMaximo' => $rangoPrecio['max_precio'] ?? 9999,
                'titulo_pagina' => 'Catálogo de Libros'
            ];

            error_log("Datos de vista preparados. Total libros: " . count($viewData['libros']));

            
            Renderer::render("libros/libros", $viewData);
            
        } catch (\Exception $e) {
            error_log("Error general en LibrosFixed: " . $e->getMessage());
            echo "<div style='padding: 20px; color: red;'>";
            echo "<h2>Error de Depuración</h2>";
            echo "<p><strong>Mensaje:</strong> " . htmlspecialchars($e->getMessage()) . "</p>";
            echo "<p><strong>Archivo:</strong> " . $e->getFile() . " línea " . $e->getLine() . "</p>";
            echo "<pre>" . htmlspecialchars($e->getTraceAsString()) . "</pre>";
            echo "</div>";
        }
    }

    private function getDatosPrueba()
    {
        return [
            [
                'libroId' => 1,
                'titulo' => 'El Alquimista',
                'autor' => 'Paulo Coelho',
                'genero' => 'Ficción',
                'descripcion' => 'Un joven pastor en busca de su leyenda personal.',
                'precio' => 300.00,
                'imagenUrl' => 'img/el-alquimista.jpg',
                'destacado' => 1,
                'stock' => 10,
                'creadoEn' => '2025-07-29 10:15:18'
            ],
            [
                'libroId' => 2,
                'titulo' => '1984',
                'autor' => 'George Orwell',
                'genero' => 'Distopía',
                'descripcion' => 'Una crítica al totalitarismo y el control social.',
                'precio' => 250.00,
                'imagenUrl' => 'img/1984.jpg',
                'destacado' => 1,
                'stock' => 10,
                'creadoEn' => '2025-07-29 10:15:18'
            ]
        ];
    }

    private function limpiarTexto(string $texto): string
    {
        return htmlspecialchars(trim($texto), ENT_QUOTES, 'UTF-8');
    }

    private function validarPrecio($precio): float
    {
        return max(0, floatval($precio));
    }

    private function formatearLibros(array $libros): array
    {
        return array_map(function($libro) {
            return [
                'libroId' => $libro['libroId'],
                'titulo' => $libro['titulo'],
                'autor' => $libro['autor'],
                'genero' => $libro['genero'],
                'precio' => number_format($libro['precio'], 2),
                'descripcion' => $this->truncarTexto($libro['descripcion'] ?? '', 150),
                'imagenUrl' => $libro['imagenUrl'] ?? 'public/images/libro-default.jpg',
                'stock' => $libro['stock'] ?? 10,
                'disponible' => ($libro['stock'] ?? 10) > 0,
                'destacado' => $libro['destacado'] ?? 0,
                'creadoEn' => $this->formatearFecha($libro['creadoEn'] ?? ''),
                'urlDetalle' => "index.php?page=Libros_Libro&id={$libro['libroId']}",
                'urlCarrito' => "index.php?page=Carrito_Agregar&id={$libro['libroId']}"
            ];
        }, $libros);
    }

    private function truncarTexto(string $texto, int $longitud): string
    {
        return strlen($texto) <= $longitud ? $texto : substr($texto, 0, $longitud) . '...';
    }

    private function formatearFecha(string $fecha): string
    {
        try {
            return date('d/m/Y', strtotime($fecha));
        } catch (\Exception $e) {
            return $fecha;
        }
    }
}
?>