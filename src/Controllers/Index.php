<?php

namespace Controllers;

use Dao\Cart\Cart;
use Dao\Books\Books;
use Utilities\Site;
use Utilities\Security;
use Views\Renderer;

class Index extends PublicController
{
    /**
     * Index run method
     *
     * @return void
     */
    public function run(): void
    {
        // Add CSS for product styling
        Site::addLink("public/css/products.css");

        // Fetch top books
        $featuredBooks = Books::getTopBooks(5);

        // Fetch available products
        $availableProducts = Cart::getProductosDisponibles();

        // Prepare view data
        $viewData = [
            "usuario" => Security::isLogged() ? Security::getUser()["email"] : "Invitado",
            "libros" => $featuredBooks,
            "products" => $availableProducts,
            "USE_URLREWRITE" => getenv("USE_URLREWRITE")
        ];

        // Render the view
        Renderer::render("index", $viewData);
    }
}
