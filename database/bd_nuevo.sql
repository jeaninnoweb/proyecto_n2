/*
Navicat MySQL Data Transfer

Source Server         : Jeancarlos
Source Server Version : 50621
Source Host           : localhost:3306
Source Database       : bd_nuevo

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2015-11-17 15:15:19
*/
DROP DATABASE IF EXISTS `bd_nuevo`;
CREATE DATABASE IF NOT EXISTS `bd_nuevo` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `bd_nuevo`; 

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cliente
-- ----------------------------
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `direccion_cliente` varchar(20) DEFAULT NULL,
  `telefono_cliente` varchar(20) DEFAULT NULL,
  `email_cliente` varchar(100) NOT NULL,
  `tipo_cliente` varchar(10) NOT NULL,
  `estado_cliente` char(1) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of cliente
-- ----------------------------
INSERT INTO `cliente` VALUES ('1', 'Av. Libertad 123', '987654321', 'Fernando Niembre', '9087654321', null);
INSERT INTO `cliente` VALUES ('2', 'Av. Lima 123', '943103555', 'Jean Carlos Sanchez', '72662378', null);

-- ----------------------------
-- Table structure for cliente_juridico
-- ----------------------------
DROP TABLE IF EXISTS `cliente_juridico`;
CREATE TABLE `cliente_juridico` (
  `ruc_clientejuridico` char(11) NOT NULL,
  `razonsocial_clientejuridico` varchar(50) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  KEY `fk_cliente_juridico_cliente1_idx` (`id_cliente`),
  CONSTRAINT `fk_cliente_juridico_cliente1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of cliente_juridico
-- ----------------------------

-- ----------------------------
-- Table structure for cliente_natural
-- ----------------------------
DROP TABLE IF EXISTS `cliente_natural`;
CREATE TABLE `cliente_natural` (
  `id_clientenatural` int(11) NOT NULL AUTO_INCREMENT,
  `apellidos_clientenatural` varchar(50) NOT NULL,
  `nombres_clientenatural` varchar(50) NOT NULL,
  `dni_clientenatural` char(8) NOT NULL,
  `sexo_clientenatural` char(1) NOT NULL,
  `fechanac_clientenatural` date NOT NULL,
  `id_cliente` int(11) NOT NULL,
  PRIMARY KEY (`id_clientenatural`),
  KEY `fk_cliente_natural_cliente1_idx` (`id_cliente`),
  CONSTRAINT `fk_cliente_natural_cliente1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of cliente_natural
-- ----------------------------

-- ----------------------------
-- Table structure for compro_pago
-- ----------------------------
DROP TABLE IF EXISTS `compro_pago`;
CREATE TABLE `compro_pago` (
  `id_compropago` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_compropago` char(1) NOT NULL,
  `nro_compropago` int(11) NOT NULL,
  PRIMARY KEY (`id_compropago`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of compro_pago
-- ----------------------------

-- ----------------------------
-- Table structure for detalle_venta
-- ----------------------------
DROP TABLE IF EXISTS `detalle_venta`;
CREATE TABLE `detalle_venta` (
  `id_venta` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad_dtventa` int(11) NOT NULL,
  `total_dtventa` decimal(19,2) NOT NULL,
  PRIMARY KEY (`id_producto`,`id_venta`),
  KEY `fk_detalle_venta_venta1_idx` (`id_venta`),
  CONSTRAINT `fk_detalle_venta_producto1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_venta_venta1` FOREIGN KEY (`id_venta`) REFERENCES `venta` (`id_venta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of detalle_venta
-- ----------------------------

-- ----------------------------
-- Table structure for permisos
-- ----------------------------
DROP TABLE IF EXISTS `permisos`;
CREATE TABLE `permisos` (
  `id_permisos` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_permisos` varchar(50) NOT NULL,
  `descripcion_permisos` varchar(100) NOT NULL,
  PRIMARY KEY (`id_permisos`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of permisos
-- ----------------------------

-- ----------------------------
-- Table structure for producto
-- ----------------------------
DROP TABLE IF EXISTS `producto`;
CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_producto` varchar(100) NOT NULL,
  `precio_producto` decimal(19,2) NOT NULL,
  `descripcion_producto` varchar(300) NOT NULL,
  `imagen_producto` varchar(100) NOT NULL,
  PRIMARY KEY (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of producto
-- ----------------------------

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(100) NOT NULL,
  `apellido_usuario` varchar(100) NOT NULL,
  `alias_usuario` varchar(50) NOT NULL,
  `password_usuario` varchar(50) NOT NULL,
  `telefono_usuario` varchar(50) NOT NULL,
  `email_usuario` varchar(100) NOT NULL,
  `id_permisos` int(11) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `id_permisos` (`id_permisos`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_permisos`) REFERENCES `permisos` (`id_permisos`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of usuario
-- ----------------------------

-- ----------------------------
-- Table structure for venta
-- ----------------------------
DROP TABLE IF EXISTS `venta`;
CREATE TABLE `venta` (
  `id_venta` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_compropago` int(11) NOT NULL,
  `fecha_venta` date NOT NULL,
  `total_venta` decimal(19,2) NOT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_usuario` (`id_usuario`),
  KEY `fk_venta_compro_pago1_idx` (`id_compropago`),
  CONSTRAINT `fk_venta_compro_pago1` FOREIGN KEY (`id_compropago`) REFERENCES `compro_pago` (`id_compropago`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `venta_ibfk_3` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  CONSTRAINT `venta_ibfk_4` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of venta
-- ----------------------------

-- ----------------------------
-- Procedure structure for sp_add_products
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_add_products`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_products`(IN `ejemplo1` varchar(50),IN `ejemplo2` varchar(50))
BEGIN
INSERT INTO producto(nombre_producto, precio_producto,descripcion_producto, imagen_producto) 
VALUES(ejemplo1,1,ejemplo2,'hola');

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for sp_login_user
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_login_user`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login_user`(IN `username` varchar(50),IN `password` varchar(50))
BEGIN
  SELECT*FROM usuario u INNER JOIN permisos p ON p.id_permisos=u.id_permisos
  WHERE u.alias_usuario=username AND password_usuario=password;
END
;;
DELIMITER ;
