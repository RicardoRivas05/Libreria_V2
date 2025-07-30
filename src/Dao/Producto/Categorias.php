<?php

namespace Dao\Producto;

use Dao\Table;

class Categorias extends Table
{
    public static function getCategorias()
    {
        $sqlstr = "SELECT * FROM categories ORDER BY name";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function getCateoriasById(int $categoriaId)
    {
        $sqlstr = "SELECT * FROM categories WHERE id = :id";
        return self::obtenerUnRegistro($sqlstr, ["id" => $categoriaId]);
    }

    public static function nuevaCategoria(string $categoria)
    {
        $sqlstr = "INSERT INTO categories (name) VALUES (:name)";
        return self::executeNonQuery($sqlstr, ["name" => $categoria]);
    }

    public static function actualizarCategoria(int $id, string $categoria): int
    {
        $sqlstr = "UPDATE categories SET name = :name WHERE id = :id";
        return self::executeNonQuery($sqlstr, ["id" => $id, "name" => $categoria]);
    }

    public static function eliminarCategoria(int $id): int
    {
        $sqlstr = "DELETE FROM categories WHERE id = :id";
        return self::executeNonQuery($sqlstr, ["id" => $id]);
    }
}
