<<<<<<< HEAD
<?php

namespace Utilities\Cart;

class CartFns
{

    public static function getAuthTimeDelta()
    {
        return 21600; // 6 * 60 * 60; // horas * minutos * segundo // 6 Horas
=======
<?php 
namespace Utilities\Cart;

class CartFns {

    public static function getAuthTimeDelta()
    {
        return 21600; // 6 * 60 * 60; // horas * minutos * segundo
>>>>>>> edcf44993d693219f0fdbb6f01ac081efed1f09e
        // No puede ser mayor a 34 días
    }

    public static function getUnAuthTimeDelta()
    {
<<<<<<< HEAD
        return 600; // 10 * 60; //h , m, s // 6 minutos
        // No puede ser mayor a 34 días
    }

    public static function getAnnonCartCode()
    {
        if (isset($_SESSION["annonCartCode"])) {
            return $_SESSION["annonCartCode"];
        };
        $_SESSION["annonCartCode"] = substr(md5("cart202502" . time() . random_int(10000, 99999)), 0, 128);
        return $_SESSION["annonCartCode"];
    }
}
=======
        return 600 ;// 10 * 60; //h , m, s
        // No puede ser mayor a 34 días
    }
}

?>
>>>>>>> edcf44993d693219f0fdbb6f01ac081efed1f09e
