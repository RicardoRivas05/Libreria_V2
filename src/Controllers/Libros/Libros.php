<?php
namespace Controllers\Libros;

use Controllers\PublicController;
use Dao\Libros\Libros as LibrosDao;
use Views\Renderer;
use Utilities\Site;

class Libros extends PublicController
{
    public function run(): void
    {
        Site::addLink("public/css/libros.css");

        try {
            
            $autor = $_GET['autor'] ?? '';
            $genero = $_GET['genero'] ?? '';
            $precioMin = isset($_GET['precio_min']) && $_GET['precio_min'] !== '' ? floatval($_GET['precio_min']) : 0;
            $precioMax = isset($_GET['precio_max']) && $_GET['precio_max'] !== '' ? floatval($_GET['precio_max']) : 9999;

            
            if ($autor || $genero || $precioMin > 0 || $precioMax < 9999) {
                $libros = LibrosDao::obtenerPorFiltro($autor, $genero, $precioMin, $precioMax);
            } else {
                $libros = LibrosDao::obtenerTodos();
            }

            
            $generos = LibrosDao::obtenerGeneros();
            $rangoPrecio = LibrosDao::obtenerRangoPrecios();

            $viewData = [
                'titulo_pagina' => 'Catálogo de Libros',
                'libros' => array_map([$this, 'formatearLibro'], $libros),
                'generos' => $generos,
                'rango_precio' => $rangoPrecio,
                'filtro_autor' => $autor,
                'filtro_genero' => $genero,
                'filtro_precio_min' => $precioMin > 0 ? $precioMin : '',
                'filtro_precio_max' => $precioMax < 9999 ? $precioMax : ''
            ];

            Renderer::render("libros/libros", $viewData);

        } catch (\Exception $e) {
            error_log("Error cargando catálogo de libros: " . $e->getMessage());
            Renderer::render("libros/error", [
                'titulo_pagina' => 'Error - Catálogo de Libros',
                'error' => 'No se pudieron cargar los libros. Intenta de nuevo más tarde.'
            ]);
        }
    }

    private function formatearLibro(array $libro): array
    {
        
        $imagenUrl = "public/imgs/libros/lib" . $libro['libroId'] . ".jpg";
        
        
        if (!file_exists($imagenUrl)) {
            $imagenUrl = "public/imgs/libros/default.jpg";
        }

        return [
            'libroId' => $libro['libroId'],
            'titulo' => $libro['titulo'],
            'autor' => $libro['autor'],
            'genero' => $libro['genero'],
            'precio' => number_format($libro['precio'], 2),
            'descripcion' => $libro['descripcion'] ?? 'Sin descripción disponible.',
            'imagenUrl' => $imagenUrl,
            'fechaPublicacion' => $libro['fechaPublicacion'] ?? '',
            'isbn' => $libro['isbn'] ?? '',
            'stock' => $libro['stock'] ?? 0,
            'disponible' => ($libro['stock'] ?? 0) > 0,
            'urlDetalle' => "index.php?page=Libros_Libro&id=" . $libro['libroId'],
            'urlCarrito' => "index.php?page=Carrito_Agregar&id=" . $libro['libroId']
        ];
    }
}