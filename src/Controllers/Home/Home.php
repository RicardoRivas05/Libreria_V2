<?php
namespace Controllers\Home;

use Controllers\PublicController;
use Views\Renderer;
use Utilities\Context;

class Home extends PublicController
{
    public function run(): void
    {
        error_reporting(E_ALL);
        ini_set('display_errors', 1);
        
        $viewData = [
            "SITE_TITLE" => "Biblioteca Virtual",
            "BASE_DIR" => Context::getContextByKey("BASE_DIR"),
            "FONT_AWESOME_KIT" => "", 
            "CURRENT_YEAR" => date("Y"),
            "PUBLIC_DEFAULT_CONTROLLER" => "Home",
            "PUBLIC_NAVIGATION" => [
                ["nav_url" => "index.php?page=Catalogo", "nav_label" => "Catálogo"],
                ["nav_url" => "index.php?page=Home_Carrito", "nav_label" => "Carrito"],
                ["nav_url" => "index.php?page=Home_Login", "nav_label" => "Iniciar Sesión"]
            ],
            
            "usuario" => $_SESSION["userName"] ?? "Invitado",
            "libros" => [
                [
                    "codLibro" => "L001", 
                    "nombre" => "El Principito", 
                    "descripcion" => "Una historia inolvidable para grandes y pequeños.", 
                    "precio" => "150.00", 
                    "stock" => 12
                ],
                [
                    "codLibro" => "L002", 
                    "nombre" => "1984", 
                    "descripcion" => "Descubre el clásico distópico de George Orwell.", 
                    "precio" => "220.00", 
                    "stock" => 7
                ],
                [
                    "codLibro" => "L003", 
                    "nombre" => "Don Quijote", 
                    "descripcion" => "La obra maestra de la literatura española.", 
                    "precio" => "180.00", 
                    "stock" => 10
                ],
                [
                    "codLibro" => "L004", 
                    "nombre" => "Cien Años de Soledad", 
                    "descripcion" => "Un clásico del realismo mágico por Gabriel García Márquez.", 
                    "precio" => "250.00", 
                    "stock" => 5
                ],
                [
                    "codLibro" => "L005", 
                    "nombre" => "La Odisea", 
                    "descripcion" => "El viaje épico de Odiseo narrado por Homero.", 
                    "precio" => "160.00", 
                    "stock" => 9
                ],
                [
                    "codLibro" => "L006", 
                    "nombre" => "Crimen y Castigo", 
                    "descripcion" => "La complejidad moral según Dostoyevski.", 
                    "precio" => "210.00", 
                    "stock" => 8
                ],
                [
                    "codLibro" => "L007", 
                    "nombre" => "Orgullo y Prejuicio", 
                    "descripcion" => "La novela romántica clásica de Jane Austen.", 
                    "precio" => "190.00", 
                    "stock" => 6
                ],
                [
                    "codLibro" => "L008", 
                    "nombre" => "Hamlet", 
                    "descripcion" => "La tragedia del príncipe de Dinamarca por Shakespeare.", 
                    "precio" => "200.00", 
                    "stock" => 11
                ],
                [
                    "codLibro" => "L009", 
                    "nombre" => "La Divina Comedia", 
                    "descripcion" => "El viaje de Dante por el Infierno, el Purgatorio y el Paraíso.", 
                    "precio" => "240.00", 
                    "stock" => 4
                ],
                [
                    "codLibro" => "L010", 
                    "nombre" => "Rayuela", 
                    "descripcion" => "Una obra maestra de Julio Cortázar para leer sin orden fijo.", 
                    "precio" => "230.00", 
                    "stock" => 5
                ],
                [
                    "codLibro" => "L011", 
                    "nombre" => "El Alquimista", 
                    "descripcion" => "Una novela sobre seguir tus sueños por Paulo Coelho.", 
                    "precio" => "175.00", 
                    "stock" => 8
                ],
                [
                    "codLibro" => "L012", 
                    "nombre" => "El Hobbit", 
                    "descripcion" => "Aventura épica en la Tierra Media por J.R.R. Tolkien.", 
                    "precio" => "280.00", 
                    "stock" => 6
                 ]
            ],
            "USE_URLREWRITE" => "0"
        ];

        Renderer::render("home/home", $viewData);
    }
}