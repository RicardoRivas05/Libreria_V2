<?php

namespace Dao\Books;

use Dao\Table;

class Books extends Table
{
    public static function getTopBooks(int $limit = 5): array
    {
        $sqlstr = "SELECT id AS codLibro, title AS nombre, description AS descripcion, price AS precio, stock, cover_image 
                   FROM books 
                   WHERE stock > 0 
                   ORDER BY created_at DESC 
                   LIMIT :limit";
        return self::obtenerRegistros($sqlstr, ["limit" => $limit]);
    }
}
