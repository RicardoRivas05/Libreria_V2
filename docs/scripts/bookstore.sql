-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 31, 2025 at 07:05 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookstore`
--

-- --------------------------------------------------------

--
-- Table structure for table `carretillaanon`
--

CREATE TABLE `carretillaanon` (
  `anoncod` varchar(128) NOT NULL,
  `productId` int(11) NOT NULL,
  `crrctd` int(5) NOT NULL,
  `crrprc` decimal(12,2) NOT NULL,
  `crrfching` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `carrito`
--

CREATE TABLE `carrito` (
  `carritoId` int(11) NOT NULL,
  `usuarioId` int(11) DEFAULT NULL,
  `libroId` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT 1,
  `agregadoEn` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `carrito`
--

INSERT INTO `carrito` (`carritoId`, `usuarioId`, `libroId`, `cantidad`, `agregadoEn`) VALUES
(3, 1, 1, 1, '2025-07-29 20:10:30'),
(4, 1, 4, 2, '2025-07-29 20:10:30');

-- --------------------------------------------------------

--
-- Table structure for table `libros`
--

CREATE TABLE `libros` (
  `libroId` int(11) NOT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `autor` varchar(255) DEFAULT NULL,
  `genero` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `imagenUrl` varchar(255) DEFAULT NULL,
  `destacado` tinyint(1) DEFAULT 0,
  `creadoEn` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `libros`
--

INSERT INTO `libros` (`libroId`, `titulo`, `autor`, `genero`, `descripcion`, `precio`, `imagenUrl`, `destacado`, `creadoEn`) VALUES
(1, 'El Alquimista', 'Paulo Coelho', 'Ficción', 'Un joven pastor en busca de su leyenda personal.', 300.00, 'img/el-alquimista.jpg', 1, '2025-07-29 20:06:33'),
(2, '1984', 'George Orwell', 'Distopía', 'Una crítica al totalitarismo y el control social.', 250.00, 'img/1984.jpg', 1, '2025-07-29 20:06:33'),
(3, 'Cien Años de Soledad', 'Gabriel García Márquez', 'Realismo Mágico', 'La historia de la familia Buendía en Macondo.', 400.00, 'img/cien-anos.jpg', 0, '2025-07-29 20:06:33'),
(4, 'El Principito', 'Antoine de Saint-Exupéry', 'Fábula', 'Un niño que vive en un pequeño planeta y viaja por el universo.', 200.00, 'img/el-principito.jpg', 1, '2025-07-29 20:06:33'),
(5, 'Don Quijote de la Mancha', 'Miguel de Cervantes', 'Clásico', 'La aventura del caballero Don Quijote y Sancho Panza.', 500.00, 'img/don-quijote.jpg', 0, '2025-07-29 20:06:33'),
(6, 'La Sombra del Viento', 'Carlos Ruiz Zafón', 'Misterio', 'Un libro olvidado que cambia la vida del joven Daniel.', 350.00, 'img/sombra-viento.jpg', 0, '2025-07-29 20:06:33'),
(7, 'Los Juegos del Hambre', 'Suzanne Collins', 'Ciencia Ficción', 'Una sociedad distópica donde adolescentes deben luchar.', 320.00, 'img/juegos-hambre.jpg', 1, '2025-07-29 20:06:33'),
(8, 'Orgullo y Prejuicio', 'Jane Austen', 'Romance', 'El amor entre Elizabeth Bennet y el Sr. Darcy.', 275.00, 'img/orgullo-prejuicio.jpg', 0, '2025-07-29 20:06:33');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `productId` int(11) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `productDescription` text DEFAULT NULL,
  `productPrice` decimal(10,2) NOT NULL,
  `productImgUrl` varchar(255) DEFAULT NULL,
  `productStock` int(11) DEFAULT 0,
  `productStatus` enum('ACT','INA') DEFAULT 'ACT'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transacciones`
--

CREATE TABLE `transacciones` (
  `transaccionId` int(11) NOT NULL,
  `usuarioId` int(11) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `estado` enum('pagado','fallido') DEFAULT 'pagado',
  `metodoPago` varchar(50) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transacciones`
--

INSERT INTO `transacciones` (`transaccionId`, `usuarioId`, `total`, `estado`, `metodoPago`, `fecha`) VALUES
(2, 1, 950.00, 'pagado', 'paypal', '2025-07-29 20:09:08');

-- --------------------------------------------------------

--
-- Table structure for table `transaccion_detalle`
--

CREATE TABLE `transaccion_detalle` (
  `detalleId` int(11) NOT NULL,
  `transaccionId` int(11) DEFAULT NULL,
  `libroId` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precioUnitario` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transaccion_detalle`
--

INSERT INTO `transaccion_detalle` (`detalleId`, `transaccionId`, `libroId`, `cantidad`, `precioUnitario`) VALUES
(9, 2, 2, 1, 250.00),
(10, 2, 3, 1, 400.00),
(11, 2, 4, 1, 200.00),
(12, 2, 8, 1, 100.00);

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `usuarioId` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `clave` varchar(255) DEFAULT NULL,
  `tipo` enum('cliente','admin') DEFAULT 'cliente',
  `estado` enum('activo','inactivo') DEFAULT 'activo',
  `creadoEn` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`usuarioId`, `nombre`, `correo`, `clave`, `tipo`, `estado`, `creadoEn`) VALUES
(1, 'Admin', 'admin@libros.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'admin', 'activo', '2025-07-29 20:04:27'),
(5, 'Juan Pérez', 'juan@correo.com', 'f6ccb3e8d609012238c0b39e60b2c9632b3cdede91e035dad1de43469768f4cc', 'cliente', 'activo', '2025-07-29 20:06:33'),
(6, 'Ana Torres', 'ana@correo.com', 'e82827b00b2ca8620beb37f879778c082b292a52270390cff35b6fe3157f4e8b', 'cliente', 'activo', '2025-07-29 20:06:33');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carretillaanon`
--
ALTER TABLE `carretillaanon`
  ADD PRIMARY KEY (`anoncod`,`productId`),
  ADD KEY `productId_idx` (`productId`);

--
-- Indexes for table `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`carritoId`),
  ADD KEY `usuarioId` (`usuarioId`),
  ADD KEY `libroId` (`libroId`);

--
-- Indexes for table `libros`
--
ALTER TABLE `libros`
  ADD PRIMARY KEY (`libroId`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`productId`);

--
-- Indexes for table `transacciones`
--
ALTER TABLE `transacciones`
  ADD PRIMARY KEY (`transaccionId`),
  ADD KEY `usuarioId` (`usuarioId`);

--
-- Indexes for table `transaccion_detalle`
--
ALTER TABLE `transaccion_detalle`
  ADD PRIMARY KEY (`detalleId`),
  ADD KEY `transaccionId` (`transaccionId`),
  ADD KEY `libroId` (`libroId`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`usuarioId`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carrito`
--
ALTER TABLE `carrito`
  MODIFY `carritoId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `libros`
--
ALTER TABLE `libros`
  MODIFY `libroId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `productId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transacciones`
--
ALTER TABLE `transacciones`
  MODIFY `transaccionId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `transaccion_detalle`
--
ALTER TABLE `transaccion_detalle`
  MODIFY `detalleId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `usuarioId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `carretillaanon`
--
ALTER TABLE `carretillaanon`
  ADD CONSTRAINT `carretillaanon_prd_key` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`usuarioId`) REFERENCES `usuarios` (`usuarioId`),
  ADD CONSTRAINT `carrito_ibfk_2` FOREIGN KEY (`libroId`) REFERENCES `libros` (`libroId`);

--
-- Constraints for table `transacciones`
--
ALTER TABLE `transacciones`
  ADD CONSTRAINT `transacciones_ibfk_1` FOREIGN KEY (`usuarioId`) REFERENCES `usuarios` (`usuarioId`);

--
-- Constraints for table `transaccion_detalle`
--
ALTER TABLE `transaccion_detalle`
  ADD CONSTRAINT `transaccion_detalle_ibfk_1` FOREIGN KEY (`transaccionId`) REFERENCES `transacciones` (`transaccionId`),
  ADD CONSTRAINT `transaccion_detalle_ibfk_2` FOREIGN KEY (`libroId`) REFERENCES `libros` (`libroId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
