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
        try {
            Site::addLink("public/css/libros.css");
            
            $id = intval($_GET["id"] ?? 0);
            if ($id <= 0) {
                Site::redirectTo("index.php?page=Libros_Libros");
                return;
            }

            $libro = LibrosDao::obtenerPorId($id);
            if (!$libro) {
                Site::redirectTo("index.php?page=Libros_Libros");
                return;
            }

            $libro['disponible'] = ($libro['stock'] ?? 10) > 0;
            $libro['stock'] = $libro['stock'] ?? 10;
            $libro['precio'] = number_format($libro['precio'], 2);
            $libro['creadoEn'] = $this->formatearFecha($libro['creadoEn'] ?? '');

            $librosRelacionados = LibrosDao::obtenerRelacionados(
                $libro['genero'], 
                $libro['libroId'], 
                4
            );

            Renderer::render("libros/libro", [
                "libro" => $libro,
                "librosRelacionados" => $this->formatearLibrosRelacionados($librosRelacionados),
                "titulo_pagina" => $libro['titulo'] . " - Detalles"
            ]);

        } catch (\Exception $e) {
            error_log("Error en Libro controller: " . $e->getMessage());
            Site::redirectTo("index.php?page=Libros_Libros");
        }
    }

    private function formatearLibrosRelacionados(array $libros): array
    {
        return array_map(function($libro) {
            return [
                'libroId' => $libro['libroId'],
                'titulo' => $libro['titulo'],
                'autor' => $libro['autor'],
                'precio' => number_format($libro['precio'], 2),
                'imagenUrl' => $libro['imagenUrl'] ?? 'public/images/libro-default.jpg'
            ];
        }, $libros);
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