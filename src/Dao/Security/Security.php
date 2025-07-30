<?php

namespace Dao\Security;

if (version_compare(phpversion(), '7.4.0', '<')) {
    define('PASSWORD_ALGORITHM', 1);  //BCRYPT
} else {
    define('PASSWORD_ALGORITHM', '2y');  //BCRYPT
}

use Exception;

class Security extends \Dao\Table
{
    static public function getUsuarios($filter = "", $page = -1, $items = 0)
    {
        $sqlstr = "";
        if ($filter == "" && $page == -1 && $items == 0) {
            $sqlstr = "SELECT * FROM users;";
        } else {
            if ($page = -1 and $items = 0) {
                $sqlstr = sprintf("SELECT * FROM users %s;", $filter);
            } else {
                $offset = ($page - 1 * $items);
                $sqlstr = sprintf(
                    "SELECT * FROM users %s limit %d, %d;",
                    $filter,
                    $offset,
                    $items
                );
            }
        }
        return self::obtenerRegistros($sqlstr, array());
    }

    static public function newUsuario($email, $password)
    {
        if (!\Utilities\Validators::IsValidEmail($email)) {
            throw new Exception("Correo no es válido");
        }
        if (!\Utilities\Validators::IsValidPassword($password)) {
            throw new Exception("Contraseña debe ser almenos 8 caracteres, 1 número, 1 mayúscula, 1 símbolo especial");
        }

        $hashedPassword = self::_hashPassword($password);

        $sqlIns = "INSERT INTO users (name, email, password, role) VALUES (:name, :email, :password, :role)";

        return self::executeNonQuery($sqlIns, [
            "name" => "New User",
            "email" => $email,
            "password" => $hashedPassword,
            "role" => "customer"
        ]);
    }

    static public function getUsuarioByEmail($email)
    {
        $sqlstr = "SELECT * FROM users WHERE email = :email";
        $params = array("email" => $email);
        return self::obtenerUnRegistro($sqlstr, $params);
    }

    static private function _saltPassword($password)
    {
        return hash_hmac(
            "sha256",
            $password,
            \Utilities\Context::getContextByKey("PWD_HASH")
        );
    }

    static private function _hashPassword($password)
    {
        return password_hash(self::_saltPassword($password), PASSWORD_ALGORITHM);
    }

    static public function verifyPassword($raw_password, $hash_password)
    {
        return password_verify(
            self::_saltPassword($raw_password),
            $hash_password
        );
    }
}
