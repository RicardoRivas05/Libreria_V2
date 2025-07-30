ALTER TABLE books MODIFY published_year SMALLINT UNSIGNED;

INSERT INTO users (name, email, password, role)
VALUES
  ('Luis Hernández', 'luis@example.com', '$2y$10$eImiTXuWVxfM37uY4JANjQ==', 'customer'),
  ('María González', 'maria@example.com', '$2y$10$eImiTXuWVxfM37uY4JANjQ==', 'customer'),
  ('Carlos Ramírez', 'carlos@example.com', '$2y$10$eImiTXuWVxfM37uY4JANjQ==', 'customer'),
  ('Ana López', 'ana@example.com', '$2y$10$eImiTXuWVxfM37uY4JANjQ==', 'customer'),
  ('Administrador', 'admin@example.com', '$2y$10$eImiTXuWVxfM37uY4JANjQ==', 'admin');


INSERT INTO authors (name)
VALUES
  ('George Orwell'),
  ('Jane Austen'),
  ('J.K. Rowling'),
  ('J.R.R. Tolkien');


INSERT INTO categories (name)
VALUES
  ('Ficción'),
  ('Fantasía'),
  ('Ciencia Ficción'),
  ('Clásico'),
  ('Romance');


INSERT INTO books (title, description, isbn, price, stock, published_year, cover_image)
VALUES
  ('1984', 'Novela distópica sobre un régimen totalitario.', '9780451524935', 9.99, 50, 1949, '1984.jpg'),
  ('Orgullo y Prejuicio', 'Novela romántica clásica.', '9781503290563', 7.99, 30, 1813, 'orgullo.jpg'),
  ('Harry Potter y la Piedra Filosofal', 'El inicio de la historia del joven mago.', '9780590353427', 12.99, 100, 1997, 'hp1.jpg'),
  ('El Hobbit', 'Aventura épica en la Tierra Media.', '9780547928227', 10.99, 40, 1937, 'hobbit.jpg');


INSERT INTO book_authors (book_id, author_id)
VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4);


INSERT INTO book_categories (book_id, category_id)
VALUES
  (1, 1), (1, 3),
  (2, 1), (2, 4), (2, 5),
  (3, 1), (3, 2),
  (4, 1), (4, 2);


INSERT INTO carts (user_id, status)
VALUES
  (1, 'open'),
  (2, 'ordered');


INSERT INTO cart_items (cart_id, book_id, quantity)
VALUES
  (1, 3, 1),
  (1, 2, 2),
  (2, 4, 1);