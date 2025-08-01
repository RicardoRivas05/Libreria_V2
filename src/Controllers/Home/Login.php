<?php
namespace Controllers\Home;

use Controllers\PublicController;
use Views\Renderer;

class Login extends PublicController
{
    public function run(): void
    {
        if ($_SERVER["REQUEST_METHOD"] === "POST") {
            $this->doLogin();
            return;
        }

        $viewData = [];
        $viewData["error"] = $_SESSION["loginError"] ?? "";
        unset($_SESSION["loginError"]);
        Renderer::render("home/login", $viewData);
    }

    private function doLogin(): void
    {
        $email = $_POST["email"] ?? "";
        $password = $_POST["password"] ?? "";

        if ($email === "admin@biblioteca.com" && $password === "admin123") {
            $_SESSION["userName"] = "Administrador";
            $_SESSION["userEmail"] = $email;
            header("Location: index.php?page=Home_Home");
            exit;
        } else {
            $_SESSION["loginError"] = "Correo o contraseña incorrectos.";
            header("Location: index.php?page=Home_Login");
            exit;
        }
    }
}
