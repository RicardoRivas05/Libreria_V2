CREATE DATABASE IF NOT EXISTS bookstore CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE bookstore;

--  Usuarios
CREATE TABLE usuarios (
    usuarioId INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    correo VARCHAR(100) UNIQUE,
    clave VARCHAR(255),
    tipo ENUM('cliente', 'admin') DEFAULT 'cliente',
    estado ENUM('activo', 'inactivo') DEFAULT 'activo',
    creadoEn DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Libros
CREATE TABLE libros (
    libroId INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255),
    autor VARCHAR(255),
    genero VARCHAR(100),
    descripcion TEXT,
    precio DECIMAL(10,2),
    imagenUrl VARCHAR(255),
    destacado BOOLEAN DEFAULT 0,
    creadoEn DATETIME DEFAULT CURRENT_TIMESTAMP
);

--  Carrito (temporal por sesión)
CREATE TABLE carrito (
    carritoId INT AUTO_INCREMENT PRIMARY KEY,
    usuarioId INT,
    libroId INT,
    cantidad INT DEFAULT 1,
    agregadoEn DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuarioId) REFERENCES usuarios(usuarioId),
    FOREIGN KEY (libroId) REFERENCES libros(libroId)
);

-- Transacciones
CREATE TABLE transacciones (
    transaccionId INT AUTO_INCREMENT PRIMARY KEY,
    usuarioId INT,
    total DECIMAL(10,2),
    estado ENUM('pagado', 'fallido') DEFAULT 'pagado',
    metodoPago VARCHAR(50),
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuarioId) REFERENCES usuarios(usuarioId)
);

--  Detalle de Transacciones
CREATE TABLE transaccion_detalle (
    detalleId INT AUTO_INCREMENT PRIMARY KEY,
    transaccionId INT,
    libroId INT,
    cantidad INT,
    precioUnitario DECIMAL(10,2),
    FOREIGN KEY (transaccionId) REFERENCES transacciones(transaccionId),
    FOREIGN KEY (libroId) REFERENCES libros(libroId)
);

-- Usuario Admin de prueba
INSERT INTO usuarios (nombre, correo, clave, tipo)
VALUES ('Admin', 'admin@libros.com', SHA2('admin123', 256), 'admin');