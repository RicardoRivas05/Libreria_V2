<?php

namespace Controllers\Home;

use Controllers\PublicController;
use Views\Renderer;
use Dao\Books\Books;

class Home extends PublicController
{
    public function run(): void
    {
        // Get top 5 featured books from database
        $featuredBooks = Books::getTopBooks(5);

        $viewData = [
            "usuario" => "Invitado",
            "libros" => $featuredBooks,
            "USE_URLREWRITE" => "0"
        ];

        Renderer::render("home/home", $viewData);
    }
}
