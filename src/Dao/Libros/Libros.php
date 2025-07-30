<?php
namespace Dao\Libros;

use Dao\Table;

class Libros extends Table
{
    public static function obtenerTodos()
    {
        $sql = "SELECT * FROM libros ORDER BY creadoEn DESC";
        return self::obtenerRegistros($sql, []);
    }

    public static function obtenerPorFiltro($autor = "", $genero = "", $min = 0, $max = 9999)
    {
        $sql = "SELECT * FROM libros 
                WHERE (:autor = '' OR autor LIKE :autor_like) 
                AND (:genero = '' OR genero LIKE :genero_like) 
                AND precio BETWEEN :min AND :max 
                ORDER BY destacado DESC, creadoEn DESC";
        
        return self::obtenerRegistros($sql, [
            "autor" => $autor,
            "autor_like" => "%{$autor}%",
            "genero" => $genero,
            "genero_like" => "%{$genero}%",
            "min" => $min,
            "max" => $max
        ]);
    }

    public static function obtenerPorId($id)
    {
        $sql = "SELECT * FROM libros WHERE libroId = :id";
        return self::obtenerUnRegistro($sql, ["id" => $id]);
    }

    public static function buscarPorTexto($texto)
    {
        $sql = "SELECT * FROM libros 
                WHERE titulo LIKE :texto 
                OR autor LIKE :texto 
                OR descripcion LIKE :texto
                OR genero LIKE :texto 
                ORDER BY 
                    CASE 
                        WHEN titulo LIKE :texto_exacto THEN 1
                        WHEN autor LIKE :texto_exacto THEN 2
                        WHEN titulo LIKE :texto THEN 3
                        WHEN autor LIKE :texto THEN 4
                        ELSE 5
                    END,
                    destacado DESC, 
                    creadoEn DESC";
        
        return self::obtenerRegistros($sql, [
            "texto" => "%{$texto}%",
            "texto_exacto" => $texto
        ]);
    }

    public static function obtenerGeneros()
    {
        $sql = "SELECT DISTINCT genero 
                FROM libros 
                WHERE genero IS NOT NULL AND genero != '' 
                ORDER BY genero";
        return self::obtenerRegistros($sql, []);
    }

    public static function obtenerAutores()
    {
        $sql = "SELECT DISTINCT autor 
                FROM libros 
                WHERE autor IS NOT NULL AND autor != '' 
                ORDER BY autor";
        return self::obtenerRegistros($sql, []);
    }

    public static function obtenerRangoPrecios()
    {
        $sql = "SELECT MIN(precio) as min_precio, MAX(precio) as max_precio FROM libros";
        $resultado = self::obtenerUnRegistro($sql, []);
        
        return $resultado ?: ['min_precio' => 0, 'max_precio' => 9999];
    }

    public static function obtenerRelacionados($genero, $libroIdExcluir, $limite = 4)
    {
        $sql = "SELECT * FROM libros 
                WHERE genero = :genero 
                AND libroId != :excluir 
                ORDER BY destacado DESC, RAND() 
                LIMIT :limite";
        
        return self::obtenerRegistros($sql, [
            "genero" => $genero,
            "excluir" => $libroIdExcluir,
            "limite" => $limite
        ]);
    }

    public static function obtenerDestacados($limite = 6)
    {
        $sql = "SELECT * FROM libros 
                WHERE destacado = 1 
                ORDER BY creadoEn DESC 
                LIMIT :limite";
        
        return self::obtenerRegistros($sql, ["limite" => $limite]);
    }

    public static function reducirStock($libroId, $cantidad = 1)
    {
        $sql = "UPDATE libros 
                SET stock = GREATEST(0, stock - :cantidad) 
                WHERE libroId = :id";
        
        return self::ejecutarNonQuery($sql, [
            "id" => $libroId,
            "cantidad" => $cantidad
        ]);
    }

    public static function incrementarStock($libroId, $cantidad = 1)
    {
        $sql = "UPDATE libros 
                SET stock = stock + :cantidad 
                WHERE libroId = :id";
        
        return self::ejecutarNonQuery($sql, [
            "id" => $libroId,
            "cantidad" => $cantidad
        ]);
    }
}
?>