/*
Navicat MySQL Data Transfer

Source Server         : Jeancarlos
Source Server Version : 50621
Source Host           : localhost:3306
Source Database       : bd_nuevo

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2015-11-17 04:31:03
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
  `id_clientejuridico` int(11) NOT NULL AUTO_INCREMENT,
  `ruc_clientejuridico` char(11) NOT NULL,
  `razonsocial_clientejuridico` varchar(50) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  PRIMARY KEY (`id_clientejuridico`),
  CONSTRAINT `fk_cliente_juridico_cliente1` FOREIGN KEY (`id_clientejuridico`) REFERENCES `cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
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
  `id_cventa` int(11) NOT NULL,
  PRIMARY KEY (`id_compropago`),
  KEY `fk_compro_pago_detalle_venta1_idx` (`id_cventa`),
  CONSTRAINT `fk_compro_pago_detalle_venta1` FOREIGN KEY (`id_cventa`) REFERENCES `detalle_venta` (`id_dventa`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of compro_pago
-- ----------------------------

-- ----------------------------
-- Table structure for detalle_venta
-- ----------------------------
DROP TABLE IF EXISTS `detalle_venta`;
CREATE TABLE `detalle_venta` (
  `id_dventa` int(11) NOT NULL AUTO_INCREMENT,
  `cant_dventa` int(11) NOT NULL,
  `total_dventa` decimal(19,2) DEFAULT NULL,
  `id_venta` int(11) NOT NULL,
  PRIMARY KEY (`id_dventa`),
  KEY `id_venta` (`id_venta`),
  CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `venta` (`id_venta`)
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
INSERT INTO `permisos` VALUES ('1', 'Administrador', 'Desarrollador de la aplicación');
INSERT INTO `permisos` VALUES ('2', 'Cajero', 'Cajero');

-- ----------------------------
-- Table structure for producto
-- ----------------------------
DROP TABLE IF EXISTS `producto`;
CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_producto` varchar(100) NOT NULL,
  `precio_producto` decimal(19,2) NOT NULL,
  `descripcion_producto` varchar(300) NOT NULL,
  `imagen_producto` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of producto
-- ----------------------------
INSERT INTO `producto` VALUES ('1', '1', '1.00', '2', 'hola');
INSERT INTO `producto` VALUES ('2', '1', '1.00', '34', 'hola');
INSERT INTO `producto` VALUES ('3', '1', '1.00', '5', 'hola');

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
INSERT INTO `usuario` VALUES ('1', 'demo', 'demo', 'demo', 'demo', 'demo', 'demo', '1');

-- ----------------------------
-- Table structure for venta
-- ----------------------------
DROP TABLE IF EXISTS `venta`;
CREATE TABLE `venta` (
  `id_venta` int(11) NOT NULL AUTO_INCREMENT,
  `numero_venta` int(11) NOT NULL,
  `fecha_venta` date NOT NULL,
  `id_producto` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `id_producto` (`id_producto`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
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
