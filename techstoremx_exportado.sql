-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 06-07-2026 a las 15:27:19
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `techstoremx`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerHistorialCliente` (IN `p_id_cliente` INT)   BEGIN
    SELECT id_venta, fecha_venta, total_venta, id_empleado
    FROM Venta
    WHERE id_cliente = p_id_cliente
    ORDER BY fecha_venta DESC;
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `CalcularPuntos` (`p_total_venta` DECIMAL(12,2)) RETURNS INT(11) DETERMINISTIC BEGIN

    DECLARE venta_puntos INT;
    SET venta_puntos = FLOOR(p_total_venta / 100);
    RETURN venta_puntos;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Apellido` varchar(100) NOT NULL,
  `Correo` varchar(100) NOT NULL,
  `Telefono` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `Nombre`, `Apellido`, `Correo`, `Telefono`) VALUES
(1, 'Ana', 'Garcia', 'ana.garcia@email.com', '5551234567'),
(2, 'Luis', 'Perez', 'luis.perez@email.com', '5552345678'),
(3, 'Maria', 'Lopez', 'maria.lopez@email.com', '5553456789'),
(4, 'Carlos', 'Martinez', 'carlos.mtz@email.com', '5554567890'),
(5, 'Sofia', 'Hernandez', 'sofia.hdez@email.com', '5555678901'),
(6, 'Jorge', 'Gomez', 'jorge.gomez@email.com', '5556789012'),
(7, 'Laura', 'Diaz', 'laura.diaz@email.com', '5557890123'),
(8, 'Pedro', 'Sanchez', 'pedro.sanchez@email.com', '5558901234'),
(9, 'Marta', 'Ramirez', 'marta.rmz@email.com', '5559012345'),
(10, 'Raul', 'Torres', 'raul.torres@email.com', '5550123456');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE `compra` (
  `Id_compra` int(11) NOT NULL,
  `Fecha_compra` datetime DEFAULT current_timestamp(),
  `Total_compra` decimal(12,2) NOT NULL CHECK (`Total_compra` >= 0),
  `Id_proveedor` int(11) NOT NULL,
  `Id_empleado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compra`
--

INSERT INTO `compra` (`Id_compra`, `Fecha_compra`, `Total_compra`, `Id_proveedor`, `Id_empleado`) VALUES
(1, '2026-06-01 10:00:00', 12000.00, 1, 9),
(2, '2026-06-05 11:30:00', 2500.00, 5, 9),
(3, '2026-06-10 14:15:00', 4000.00, 3, 9),
(4, '2026-06-15 09:45:00', 8500.00, 6, 9),
(5, '2026-06-20 16:20:00', 16000.00, 4, 9),
(6, '2026-06-25 13:10:00', 3000.00, 7, 9),
(7, '2026-07-01 10:30:00', 4500.00, 8, 9),
(8, '2026-07-02 12:00:00', 3200.00, 9, 9),
(9, '2026-07-03 15:45:00', 2000.00, 2, 9),
(10, '2026-07-04 11:15:00', 1500.00, 10, 9);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compra`
--

CREATE TABLE `detalle_compra` (
  `Id_detalle_compra` int(11) NOT NULL,
  `Id_compra` int(11) NOT NULL,
  `Id_producto` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL CHECK (`Cantidad` > 0),
  `Precio_unitario_compra` decimal(10,2) NOT NULL CHECK (`Precio_unitario_compra` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_compra`
--

INSERT INTO `detalle_compra` (`Id_detalle_compra`, `Id_compra`, `Id_producto`, `Cantidad`, `Precio_unitario_compra`) VALUES
(1, 1, 1, 1, 12000.00),
(2, 2, 2, 10, 250.00),
(3, 3, 3, 5, 800.00),
(4, 4, 4, 3, 2833.33),
(5, 5, 5, 2, 8000.00),
(6, 6, 6, 3, 1000.00),
(7, 7, 7, 2, 2250.00),
(8, 8, 8, 2, 1600.00),
(9, 9, 9, 2, 1000.00),
(10, 10, 10, 10, 150.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `Id_detalle_venta` int(11) NOT NULL,
  `Id_venta` int(11) NOT NULL,
  `Id_producto` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL CHECK (`Cantidad` > 0),
  `Precio_unitario_venta` decimal(10,2) NOT NULL CHECK (`Precio_unitario_venta` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`Id_detalle_venta`, `Id_venta`, `Id_producto`, `Cantidad`, `Precio_unitario_venta`) VALUES
(1, 1, 1, 1, 15000.00),
(2, 2, 2, 1, 350.00),
(3, 3, 3, 2, 850.00),
(4, 4, 4, 1, 3200.00),
(5, 5, 5, 1, 8500.00),
(6, 6, 6, 1, 1200.00),
(7, 7, 7, 1, 2500.00),
(8, 8, 8, 1, 1800.00),
(9, 9, 9, 1, 1100.00),
(10, 10, 10, 2, 250.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `Id_empleado` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Apellido` varchar(100) NOT NULL,
  `Puesto` varchar(100) NOT NULL,
  `Fecha_contratacion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`Id_empleado`, `Nombre`, `Apellido`, `Puesto`, `Fecha_contratacion`) VALUES
(1, 'Juan', 'Ruiz', 'Gerente', '2025-01-15'),
(2, 'Elena', 'Flores', 'Vendedor', '2025-03-10'),
(3, 'Miguel', 'Vargas', 'Vendedor', '2025-05-20'),
(4, 'Diana', 'Rios', 'Cajero', '2025-08-01'),
(5, 'Andres', 'Castro', 'Cajero', '2025-11-15'),
(6, 'Valeria', 'Ortiz', 'Soporte IT', '2026-01-10'),
(7, 'Roberto', 'Silva', 'Almacenista', '2026-02-05'),
(8, 'Patricia', 'Luna', 'Vendedor', '2026-03-20'),
(9, 'Fernando', 'Reyes', 'Comprador', '2026-04-12'),
(10, 'Carmen', 'Mendoza', 'Atenci?n a Clientes', '2026-06-01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `Id_producto` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Descripcion` text DEFAULT NULL,
  `Precio_venta` decimal(10,2) NOT NULL CHECK (`Precio_venta` >= 0),
  `Id_proveedor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`Id_producto`, `Nombre`, `Descripcion`, `Precio_venta`, `Id_proveedor`) VALUES
(1, 'Laptop Pro 15', 'Laptop de 15 pulgadas, 16GB RAM, 512GB SSD', 15000.00, 1),
(2, 'Mouse Inalambrico', 'Mouse ergonomico Bluetooth', 350.00, 5),
(3, 'Teclado Mecanico', 'Teclado RGB switches azules', 850.00, 3),
(4, 'Monitor 27\"', 'Monitor LED 1080p 75Hz', 3200.00, 6),
(5, 'Smartphone X', 'Telefono inteligente 128GB', 8500.00, 4),
(6, 'Audifonos Noise Cancelling', 'Audifonos inalambricos con cancelacion de ruido', 1200.00, 7),
(7, 'Impresora Multifuncional', 'Impresora a color con escaner', 2500.00, 8),
(8, 'Router Wi-Fi 6', 'Router de doble banda alta velocidad', 1800.00, 9),
(9, 'Disco Duro Externo 1TB', 'Almacenamiento USB 3.0', 1100.00, 2),
(10, 'Funda para Laptop', 'Funda acolchada para equipos de 15 pulgadas', 250.00, 10);

--
-- Disparadores `producto`
--
DELIMITER $$
CREATE TRIGGER `Trigger_Validar_Precios` BEFORE UPDATE ON `producto` FOR EACH ROW BEGIN
    IF NEW.Precio_venta < 0 THEN
        SET NEW.Precio_venta = 0;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `Id_proveedor` int(11) NOT NULL,
  `Nombre_empresa` varchar(100) NOT NULL,
  `Contacto` varchar(100) DEFAULT NULL,
  `Telefono` varchar(100) DEFAULT NULL,
  `Correo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`Id_proveedor`, `Nombre_empresa`, `Contacto`, `Telefono`, `Correo`) VALUES
(1, 'TechGlobal', 'Hector Salas', '8001112222', 'ventas@techglobal.com'),
(2, 'ElectroMax', 'Silvia Pinal', '8003334444', 'contacto@electromax.com'),
(3, 'GamaComputers', 'Oscar Vega', '8005556666', 'distribucion@gama.com'),
(4, 'SmartMobiles', 'Teresa Cruz', '8007778888', 'b2b@smartmobiles.com'),
(5, 'CablesYMas', 'Victor Paz', '8009990000', 'ventas@cablesymas.com'),
(6, 'VisionDisplays', 'Monica Gil', '8001231234', 'monitores@vision.com'),
(7, 'SoundPro', 'Hugo Lara', '8004564567', 'audio@soundpro.com'),
(8, 'PrintSolutions', 'Irene Mora', '8007897890', 'impresion@printsol.com'),
(9, 'NetWorkingTech', 'Javier Cano', '8003213210', 'redes@networking.com'),
(10, 'AccesoriosPlus', 'Raquel Soto', '8006546543', 'mayoristas@accplus.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `Id_venta` int(11) NOT NULL,
  `Fecha_venta` datetime DEFAULT current_timestamp(),
  `Total_venta` decimal(12,2) NOT NULL CHECK (`Total_venta` >= 0),
  `Id_cliente` int(11) NOT NULL,
  `Id_empleado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`Id_venta`, `Fecha_venta`, `Total_venta`, `Id_cliente`, `Id_empleado`) VALUES
(1, '2026-07-01 10:30:00', 15000.00, 1, 2),
(2, '2026-07-01 12:45:00', 350.00, 2, 3),
(3, '2026-07-02 14:20:00', 1700.00, 3, 4),
(4, '2026-07-02 16:10:00', 3200.00, 4, 2),
(5, '2026-07-03 09:30:00', 8500.00, 5, 3),
(6, '2026-07-03 11:15:00', 1200.00, 6, 4),
(7, '2026-07-03 13:50:00', 2500.00, 7, 2),
(8, '2026-07-04 10:05:00', 1800.00, 8, 3),
(9, '2026-07-04 12:30:00', 1100.00, 9, 4),
(10, '2026-07-04 15:00:00', 500.00, 10, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_historico`
--

CREATE TABLE `venta_historico` (
  `id_venta` int(11) NOT NULL,
  `fecha_venta` datetime NOT NULL,
  `total_venta` decimal(12,2) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
PARTITION BY RANGE (year(`fecha_venta`))
(
PARTITION p2025 VALUES LESS THAN (2026) ENGINE=InnoDB,
PARTITION p2026 VALUES LESS THAN (2027) ENGINE=InnoDB,
PARTITION p2027 VALUES LESS THAN (2028) ENGINE=InnoDB,
PARTITION p_futuro VALUES LESS THAN MAXVALUE ENGINE=InnoDB
);

--
-- Volcado de datos para la tabla `venta_historico`
--

INSERT INTO `venta_historico` (`id_venta`, `fecha_venta`, `total_venta`, `id_cliente`, `id_empleado`) VALUES
(1, '2025-05-10 10:00:00', 1500.00, 1, 1),
(2, '2025-11-20 15:30:00', 2000.00, 2, 2),
(3, '2026-03-15 09:00:00', 350.00, 3, 3),
(4, '2026-07-05 12:00:00', 4200.00, 4, 1),
(5, '2027-01-10 11:15:00', 800.00, 1, 2),
(6, '2028-06-25 14:45:00', 5500.00, 2, 3);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`),
  ADD KEY `idx_cliente_correo` (`Correo`);

--
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`Id_compra`),
  ADD KEY `Id_proveedor` (`Id_proveedor`),
  ADD KEY `Id_empleado` (`Id_empleado`);

--
-- Indices de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD PRIMARY KEY (`Id_detalle_compra`),
  ADD KEY `Id_compra` (`Id_compra`),
  ADD KEY `Id_producto` (`Id_producto`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`Id_detalle_venta`),
  ADD KEY `Id_venta` (`Id_venta`),
  ADD KEY `Id_producto` (`Id_producto`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`Id_empleado`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`Id_producto`),
  ADD KEY `Id_proveedor` (`Id_proveedor`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`Id_proveedor`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`Id_venta`),
  ADD KEY `Id_cliente` (`Id_cliente`),
  ADD KEY `Id_empleado` (`Id_empleado`),
  ADD KEY `idx_venta_fecha` (`Fecha_venta`);

--
-- Indices de la tabla `venta_historico`
--
ALTER TABLE `venta_historico`
  ADD PRIMARY KEY (`id_venta`,`fecha_venta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `compra`
--
ALTER TABLE `compra`
  MODIFY `Id_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  MODIFY `Id_detalle_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `Id_detalle_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `Id_empleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `Id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `Id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `Id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`Id_proveedor`) REFERENCES `proveedor` (`Id_proveedor`),
  ADD CONSTRAINT `compra_ibfk_2` FOREIGN KEY (`Id_empleado`) REFERENCES `empleado` (`Id_empleado`);

--
-- Filtros para la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD CONSTRAINT `detalle_compra_ibfk_1` FOREIGN KEY (`Id_compra`) REFERENCES `compra` (`Id_compra`),
  ADD CONSTRAINT `detalle_compra_ibfk_2` FOREIGN KEY (`Id_producto`) REFERENCES `producto` (`Id_producto`);

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`Id_venta`) REFERENCES `venta` (`Id_venta`),
  ADD CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`Id_producto`) REFERENCES `producto` (`Id_producto`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`Id_proveedor`) REFERENCES `proveedor` (`Id_proveedor`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`Id_cliente`) REFERENCES `cliente` (`id_cliente`),
  ADD CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`Id_empleado`) REFERENCES `empleado` (`Id_empleado`);

DELIMITER $$
--
-- Eventos
--
CREATE DEFINER=`root`@`localhost` EVENT `Ajuste_Precio_Laptop` ON SCHEDULE EVERY 1 MINUTE STARTS '2026-07-05 13:52:27' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE producto 
    SET Precio_venta = Precio_venta + 10 
    WHERE Id_producto = 1$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
