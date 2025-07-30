<?php

namespace Dao\Cart;

class Cart extends \Dao\Table
{
    // Obtener libros agregados por un usuario
    public static function getCartByUserId($usuarioId)
    {
        $sql = "SELECT l.*, c.cantidad, c.agregadoEn 
                FROM libros l
                JOIN carrito c ON l.libroId = c.libroId
                WHERE c.usuarioId = :usuarioId";
        return self::obtenerRegistros($sql, ["usuarioId" => $usuarioId]);
    }

    // Agregar un libro al carrito (o actualizar cantidad)
    public static function addToCart($usuarioId, $libroId, $cantidad = 1)
    {
        $sqlCheck = "SELECT * FROM carrito WHERE usuarioId = :usuarioId AND libroId = :libroId";
        $existe = self::obtenerUnRegistro($sqlCheck, [
            "usuarioId" => $usuarioId,
            "libroId" => $libroId
        ]);

        if ($existe) {
            $sqlUpdate = "UPDATE carrito SET cantidad = cantidad + :cantidad WHERE usuarioId = :usuarioId AND libroId = :libroId";
            return self::executeNonQuery($sqlUpdate, [
                "cantidad" => $cantidad,
                "usuarioId" => $usuarioId,
                "libroId" => $libroId
            ]);
        } else {
            $sqlInsert = "INSERT INTO carrito (usuarioId, libroId, cantidad, agregadoEn) VALUES (:usuarioId, :libroId, :cantidad, NOW())";
            return self::executeNonQuery($sqlInsert, [
                "usuarioId" => $usuarioId,
                "libroId" => $libroId,
                "cantidad" => $cantidad
            ]);
        }
    }

    // Eliminar un libro del carrito
    public static function removeFromCart($usuarioId, $libroId)
    {
        $sql = "DELETE FROM carrito WHERE usuarioId = :usuarioId AND libroId = :libroId";
        return self::executeNonQuery($sql, [
            "usuarioId" => $usuarioId,
            "libroId" => $libroId
        ]);
    }

    // Vaciar carrito
    public static function emptyCart($usuarioId)
    {
        $sql = "DELETE FROM carrito WHERE usuarioId = :usuarioId";
        return self::executeNonQuery($sql, [
            "usuarioId" => $usuarioId
        ]);
    }
}
