<?php
namespace Controllers\Libros;

use Controllers\PublicController;
use Dao\Libros\Libros as LibrosDao;
use Views\Renderer;
use Utilities\Site;

class Libro extends PublicController
{
    public function run(): void
    {
        Site::addLink("public/css/libros.css");

        $libroId = $_GET['id'] ?? '';
        if (!ctype_digit($libroId)) {
            $this->mostrarError("ID inválido de libro.");
            return;
        }

        $libroId = intval($libroId);

        try {
            $libro = LibrosDao::obtenerPorId($libroId);
            if (!$libro) {
                $this->mostrarError("Libro no encontrado.");
                return;
            }

            
            $librosRelacionados = [];
            if (!empty($libro['genero'])) {
                $librosRelacionados = LibrosDao::obtenerRelacionados($libro['genero'], $libroId, 4);
            }

            $viewData = array_merge(
                $this->formatearLibro($libro),
                [
                    'titulo_pagina' => ($libro['titulo'] ?? 'Detalle del Libro') . ' - Librería Virtual',
                    'libros_relacionados' => array_map([$this, 'formatearLibroRelacionado'], $librosRelacionados)
                ]
            );
            
            Renderer::render("libros/libro", $viewData);

        } catch (\Exception $e) {
            error_log("Error cargando libro ID $libroId: " . $e->getMessage());
            $this->mostrarError("Error inesperado al cargar el libro.");
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
            'fechaPublicacion' => $this->formatearFecha($libro['fechaPublicacion'] ?? ''),
            'isbn' => $libro['isbn'] ?? '',
            'stock' => $libro['stock'] ?? 0,
            'disponible' => ($libro['stock'] ?? 0) > 0,
            'urlCarrito' => "index.php?page=Carrito_Agregar&id=" . $libro['libroId']
        ];
    }

    private function formatearLibroRelacionado(array $libro): array
    {
        
        $imagenUrl = "public/imgs/libros/lib" . $libro['libroId'] . ".jpg";
        
        
        if (!file_exists($imagenUrl)) {
            $imagenUrl = "public/imgs/libros/default.jpg";
        }

        return [
            'libroId' => $libro['libroId'],
            'titulo' => $libro['titulo'],
            'autor' => $libro['autor'],
            'precio' => number_format($libro['precio'], 2),
            'imagenUrl' => $imagenUrl,
            'urlDetalle' => "index.php?page=Libros_Libro&id=" . $libro['libroId']
        ];
    }

    private function formatearFecha(string $fecha): string
    {
        if (empty($fecha)) {
            return '';
        }

        try {
            $datetime = new \DateTime($fecha);
            return $datetime->format('d/m/Y');
        } catch (\Exception $e) {
            return $fecha; 
        }
    }

    private function mostrarError(string $mensaje): void
    {
        Renderer::render("libros/error", [
            'titulo_pagina' => 'Error - Detalle del Libro',
            'error' => $mensaje
        ]);
    }
}