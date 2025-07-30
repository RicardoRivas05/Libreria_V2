<?php

namespace Dao\Cart;

use Dao\Table;

class Cart extends Table
{
    // ...existing code...

    public static function getAnonCart(string $anonCartCode)
    {
        // For anonymous carts, we'll use a different approach since your new schema
        // doesn't have a separate anonymous cart table. We can either:
        // 1. Create a temporary user for anonymous carts, or
        // 2. Store in session and database with a special identifier

        // Option 1: Using session storage for anonymous carts
        if (!isset($_SESSION['anon_cart'])) {
            $_SESSION['anon_cart'] = [];
        }

        $anonCart = [];
        foreach ($_SESSION['anon_cart'] as $item) {
            if ($item['anon_code'] === $anonCartCode) {
                // Get book details from database
                $book = self::obtenerUnRegistro(
                    "SELECT * FROM books WHERE id = :book_id",
                    ["book_id" => $item['book_id']]
                );
                if ($book) {
                    $book['quantity'] = $item['quantity'];
                    $book['item_price'] = $book['price'];
                    $book['cart_updated'] = $item['updated_at'];
                    $anonCart[] = $book;
                }
            }
        }

        return $anonCart;
    }

    public static function addToAnonCart(int $bookId, string $anonCartCode, int $amount, float $price)
    {
        if (!isset($_SESSION['anon_cart'])) {
            $_SESSION['anon_cart'] = [];
        }

        // Find existing item
        $found = false;
        foreach ($_SESSION['anon_cart'] as &$item) {
            if ($item['anon_code'] === $anonCartCode && $item['book_id'] === $bookId) {
                $item['quantity'] += $amount;
                $item['updated_at'] = date('Y-m-d H:i:s');
                if ($item['quantity'] <= 0) {
                    // Remove item if quantity is 0 or less
                    $_SESSION['anon_cart'] = array_filter($_SESSION['anon_cart'], function ($cartItem) use ($anonCartCode, $bookId) {
                        return !($cartItem['anon_code'] === $anonCartCode && $cartItem['book_id'] === $bookId);
                    });
                }
                $found = true;
                break;
            }
        }

        // Add new item if not found and amount is positive
        if (!$found && $amount > 0) {
            $_SESSION['anon_cart'][] = [
                'anon_code' => $anonCartCode,
                'book_id' => $bookId,
                'quantity' => $amount,
                'price' => $price,
                'updated_at' => date('Y-m-d H:i:s')
            ];
        }

        return true;
    }

    public static function moveAnonToAuth(string $anonCartCode, int $userId)
    {
        if (!isset($_SESSION['anon_cart'])) {
            return true;
        }

        // Get or create user's cart
        $cartSql = "SELECT id FROM carts WHERE user_id = :user_id AND status = 'open' LIMIT 1";
        $cart = self::obtenerUnRegistro($cartSql, ["user_id" => $userId]);

        if (!$cart) {
            self::executeNonQuery(
                "INSERT INTO carts (user_id, status) VALUES (:user_id, 'open')",
                ["user_id" => $userId]
            );
            $cart = self::obtenerUnRegistro($cartSql, ["user_id" => $userId]);
        }

        $cartId = $cart["id"];

        // Move items from anonymous cart to authenticated cart
        foreach ($_SESSION['anon_cart'] as $item) {
            if ($item['anon_code'] === $anonCartCode) {
                // Check if item already exists in authenticated cart
                $existingItem = self::obtenerUnRegistro(
                    "SELECT * FROM cart_items WHERE cart_id = :cart_id AND book_id = :book_id",
                    ["cart_id" => $cartId, "book_id" => $item['book_id']]
                );

                if ($existingItem) {
                    // Update quantity
                    self::executeNonQuery(
                        "UPDATE cart_items SET quantity = quantity + :quantity WHERE cart_id = :cart_id AND book_id = :book_id",
                        [
                            "cart_id" => $cartId,
                            "book_id" => $item['book_id'],
                            "quantity" => $item['quantity']
                        ]
                    );
                } else {
                    // Insert new item
                    self::executeNonQuery(
                        "INSERT INTO cart_items (cart_id, book_id, quantity) VALUES (:cart_id, :book_id, :quantity)",
                        [
                            "cart_id" => $cartId,
                            "book_id" => $item['book_id'],
                            "quantity" => $item['quantity']
                        ]
                    );
                }
            }
        }

        // Clear anonymous cart for this code
        $_SESSION['anon_cart'] = array_filter($_SESSION['anon_cart'], function ($item) use ($anonCartCode) {
            return $item['anon_code'] !== $anonCartCode;
        });

        return true;
    }

    public static function getProductosDisponibles()
    {
        $sqlstr = "SELECT * FROM books WHERE stock > 0";
        return self::obtenerRegistros($sqlstr, []);
    }
}
