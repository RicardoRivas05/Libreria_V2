<?php

namespace Utilities;

use Dao\Security\Security as DaoSecurity;
<<<<<<< HEAD

class Security
{
    private function __construct() {}
    private function __clone() {}
=======
class Security {
    private function __construct()
    {
        
    }
    private function __clone()
    {
        
    }
>>>>>>> edcf44993d693219f0fdbb6f01ac081efed1f09e
    public static function logout()
    {
        unset($_SESSION["login"]);
    }
    public static function login($userId, $userName, $userEmail)
    {
        $_SESSION["login"] = array(
            "isLogged" => true,
            "userId" => $userId,
            "userName" => $userName,
            "userEmail" => $userEmail
        );
    }
<<<<<<< HEAD
    public static function isLogged(): bool
=======
    public static function isLogged():bool
>>>>>>> edcf44993d693219f0fdbb6f01ac081efed1f09e
    {
        return isset($_SESSION["login"]) && $_SESSION["login"]["isLogged"];
    }
    public static function getUser()
    {
        if (isset($_SESSION["login"])) {
            return $_SESSION["login"];
        }
        return false;
    }
    public static function getUserId()
    {
        if (isset($_SESSION["login"])) {
            return $_SESSION["login"]["userId"];
        }
        return 0;
    }
<<<<<<< HEAD
    public static function isAuthorized($userId, $function, $type = 'FNC'): bool
=======
    public static function isAuthorized($userId, $function, $type = 'FNC'):bool
>>>>>>> edcf44993d693219f0fdbb6f01ac081efed1f09e
    {
        if (\Utilities\Context::getContextByKey("DEVELOPMENT") == "1") {
            $functionInDb = DaoSecurity::getFeature($function);
            if (!$functionInDb) {
                DaoSecurity::addNewFeature($function, $function, "ACT", $type);
            }
        }
        return DaoSecurity::getFeatureByUsuario($userId, $function);
    }
<<<<<<< HEAD
    public static function isInRol($userId, $rol): bool
=======
    public static function isInRol($userId, $rol):bool
>>>>>>> edcf44993d693219f0fdbb6f01ac081efed1f09e
    {
        if (\Utilities\Context::getContextByKey("DEVELOPMENT") == "1") {
            $rolInDb = DaoSecurity::getRol($rol);
            if (!$rolInDb) {
                DaoSecurity::addNewRol($rol, $rol, "ACT");
            }
        }
        return DaoSecurity::isUsuarioInRol($userId, $rol);
    }
}
