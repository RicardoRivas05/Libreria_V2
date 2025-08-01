<?php
namespace Controllers\Home;

use Controllers\PublicController;
use Views\Renderer;

class Register extends PublicController
{
    public function run(): void
    {
        if ($_SERVER["REQUEST_METHOD"] === "POST") {
            $this->doRegister();
            return;
        }

        $viewData = [];
        $viewData["error"] = $_SESSION["registerError"] ?? "";
        unset($_SESSION["registerError"]);
        Renderer::render("home/register", $viewData);
    }

    private function doRegister(): void
    {
        $email = $_POST["email"] ?? "";
        $password = $_POST["password"] ?? "";
        $passwordConfirm = $_POST["password_confirm"] ?? "";

        if (empty($email) || empty($password) || empty($passwordConfirm)) {
            $_SESSION["registerError"] = "Todos los campos son obligatorios.";
            header("Location: index.php?page=Home_Register");
            exit;
        }

        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $_SESSION["registerError"] = "El correo no es válido.";
            header("Location: index.php?page=Home_Register");
            exit;
        }

        if ($password !== $passwordConfirm) {
            $_SESSION["registerError"] = "Las contraseñas no coinciden.";
            header("Location: index.php?page=Home_Register");
            exit;
        }
        $_SESSION["userName"] = $email;
        $_SESSION["userEmail"] = $email;
      
        header("Location: index.php?page=Home_Home");
        exit;
    }
}
