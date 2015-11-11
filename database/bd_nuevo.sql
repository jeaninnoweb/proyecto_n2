-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-11-2015 a las 13:47:45
-- Versión del servidor: 5.6.21
-- Versión de PHP: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `bd_nuevo`
--
CREATE DATABASE IF NOT EXISTS `bd_nuevo` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `bd_nuevo`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
`id_cliente` int(11) NOT NULL,
  `nombre_cliente` varchar(100) NOT NULL,
  `dni_cliente` varchar(10) NOT NULL,
  `direccion_cliente` varchar(20) DEFAULT NULL,
  `telefono_cliente` varchar(20) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `nombre_cliente`, `dni_cliente`, `direccion_cliente`, `telefono_cliente`) VALUES
(1, 'Fernando Niembre', '9087654321', 'Av. Libertad 123', '987654321'),
(2, 'Jean Carlos Sanchez', '72662378', 'Av. Lima 123', '943103555');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

DROP TABLE IF EXISTS `compra`;
CREATE TABLE IF NOT EXISTS `compra` (
`id_compra` int(11) NOT NULL,
  `tipodoc_compra` varchar(10) NOT NULL,
  `nrodoc_compra` int(11) NOT NULL,
  `fecha_compra` date NOT NULL,
  `id_producto` int(11) NOT NULL,
  `id_proveedor` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compra`
--

DROP TABLE IF EXISTS `detalle_compra`;
CREATE TABLE IF NOT EXISTS `detalle_compra` (
`id_dcompra` int(11) NOT NULL,
  `cant_dcompra` int(11) NOT NULL,
  `total_dcompra` decimal(19,2) DEFAULT NULL,
  `id_compra` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

DROP TABLE IF EXISTS `detalle_venta`;
CREATE TABLE IF NOT EXISTS `detalle_venta` (
`id_dventa` int(11) NOT NULL,
  `cant_dventa` int(11) NOT NULL,
  `total_dventa` decimal(19,2) DEFAULT NULL,
  `id_venta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

DROP TABLE IF EXISTS `permisos`;
CREATE TABLE IF NOT EXISTS `permisos` (
`id_permisos` int(11) NOT NULL,
  `nombre_permisos` varchar(50) NOT NULL,
  `descripcion_permisos` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`id_permisos`, `nombre_permisos`, `descripcion_permisos`) VALUES
(1, 'Administrador', 'Desarrollador de la aplicación'),
(2, 'Cajero', 'Cajero');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

DROP TABLE IF EXISTS `producto`;
CREATE TABLE IF NOT EXISTS `producto` (
`id_producto` int(11) NOT NULL,
  `modelo_producto` varchar(50) NOT NULL,
  `nombre_producto` varchar(100) NOT NULL,
  `precio_producto` decimal(19,2) NOT NULL,
  `costo_producto` decimal(19,2) NOT NULL,
  `stock_producto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
CREATE TABLE IF NOT EXISTS `proveedor` (
`id_proveedor` int(11) NOT NULL,
  `nom_proveedor` varchar(100) NOT NULL,
  `tipodoc_proveedor` varchar(10) NOT NULL,
  `nrodoc_proveedor` int(11) NOT NULL,
  `direccion_proveedor` varchar(50) DEFAULT NULL,
  `telefono_proveedor` varchar(20) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`id_proveedor`, `nom_proveedor`, `tipodoc_proveedor`, `nrodoc_proveedor`, `direccion_proveedor`, `telefono_proveedor`) VALUES
(1, 'FERRETERIA HERRERA', 'RUC', 2147483647, 'AV. ANCHOVETA 432', '9236354345');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
`id_usuario` int(11) NOT NULL,
  `nombre_usuario` varchar(100) NOT NULL,
  `apellido_usuario` varchar(100) NOT NULL,
  `alias_usuario` varchar(50) NOT NULL,
  `password_usuario` varchar(50) NOT NULL,
  `telefono_usuario` varchar(50) NOT NULL,
  `email_usuario` varchar(100) NOT NULL,
  `id_permisos` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombre_usuario`, `apellido_usuario`, `alias_usuario`, `password_usuario`, `telefono_usuario`, `email_usuario`, `id_permisos`) VALUES
(1, 'demo', 'demo', 'demo', 'demo', 'demo', 'demo', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

DROP TABLE IF EXISTS `venta`;
CREATE TABLE IF NOT EXISTS `venta` (
`id_venta` int(11) NOT NULL,
  `numero_venta` int(11) NOT NULL,
  `fecha_venta` date NOT NULL,
  `id_producto` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
 ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
 ADD PRIMARY KEY (`id_compra`), ADD KEY `id_producto` (`id_producto`), ADD KEY `id_proveedor` (`id_proveedor`), ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
 ADD PRIMARY KEY (`id_dcompra`), ADD KEY `id_compra` (`id_compra`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
 ADD PRIMARY KEY (`id_dventa`), ADD KEY `id_venta` (`id_venta`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
 ADD PRIMARY KEY (`id_permisos`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
 ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
 ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
 ADD PRIMARY KEY (`id_usuario`), ADD KEY `id_permisos` (`id_permisos`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
 ADD PRIMARY KEY (`id_venta`), ADD KEY `id_producto` (`id_producto`), ADD KEY `id_cliente` (`id_cliente`), ADD KEY `id_usuario` (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `compra`
--
ALTER TABLE `compra`
MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
MODIFY `id_dcompra` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
MODIFY `id_dventa` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
MODIFY `id_permisos` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compra`
--
ALTER TABLE `compra`
ADD CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
ADD CONSTRAINT `compra_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`),
ADD CONSTRAINT `compra_ibfk_3` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`);

--
-- Filtros para la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
ADD CONSTRAINT `detalle_compra_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compra` (`id_compra`);

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
ADD CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `venta` (`id_venta`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_permisos`) REFERENCES `permisos` (`id_permisos`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
ADD CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
ADD CONSTRAINT `venta_ibfk_3` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
ADD CONSTRAINT `venta_ibfk_4` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
