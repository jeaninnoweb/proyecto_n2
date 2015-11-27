/*
Navicat MySQL Data Transfer

Source Server         : Jeancarlos
Source Server Version : 50621
Source Host           : localhost:3306
Source Database       : bd_nuevo

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2015-11-27 04:10:48
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
  `id_persona` int(11) NOT NULL,
  `direccion_cliente` varchar(20) DEFAULT NULL,
  `telefono_cliente` varchar(20) DEFAULT NULL,
  `email_cliente` varchar(100) NOT NULL,
  `estado_cliente` char(1) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  KEY `fk_cliente_persona1_idx` (`id_persona`),
  CONSTRAINT `fk_cliente_persona1` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of cliente
-- ----------------------------
INSERT INTO `cliente` VALUES ('1', '2', 'av. lima', '12345678', 'demo@hotmail.com', '1');
INSERT INTO `cliente` VALUES ('2', '3', 'jr ica', '22234545', 'cliente@hotmail.com', '1');

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
  `id_cliente` int(11) NOT NULL,
  PRIMARY KEY (`id_clientenatural`),
  KEY `fk_cliente_natural_cliente1_idx` (`id_cliente`),
  CONSTRAINT `fk_cliente_natural_cliente1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of cliente_natural
-- ----------------------------
INSERT INTO `cliente_natural` VALUES ('1', '1');
INSERT INTO `cliente_natural` VALUES ('2', '2');

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
INSERT INTO `detalle_venta` VALUES ('1', '1', '3', '6.00');
INSERT INTO `detalle_venta` VALUES ('2', '1', '6', '12.00');
INSERT INTO `detalle_venta` VALUES ('3', '1', '3', '6.00');
INSERT INTO `detalle_venta` VALUES ('1', '2', '2', '6.00');
INSERT INTO `detalle_venta` VALUES ('2', '2', '1', '3.00');
INSERT INTO `detalle_venta` VALUES ('1', '3', '1', '1.00');
INSERT INTO `detalle_venta` VALUES ('3', '3', '6', '6.00');

-- ----------------------------
-- Table structure for empleado
-- ----------------------------
DROP TABLE IF EXISTS `empleado`;
CREATE TABLE `empleado` (
  `id_empleado` int(11) NOT NULL AUTO_INCREMENT,
  `id_persona` int(11) NOT NULL,
  PRIMARY KEY (`id_empleado`),
  KEY `fk_empleado_persona1_idx` (`id_persona`),
  CONSTRAINT `fk_empleado_persona1` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of empleado
-- ----------------------------
INSERT INTO `empleado` VALUES ('1', '1');

-- ----------------------------
-- Table structure for permisos
-- ----------------------------
DROP TABLE IF EXISTS `permisos`;
CREATE TABLE `permisos` (
  `id_permisos` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_permisos` varchar(50) NOT NULL,
  `descripcion_permisos` varchar(100) NOT NULL,
  PRIMARY KEY (`id_permisos`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of permisos
-- ----------------------------
INSERT INTO `permisos` VALUES ('1', 'ADMINISTRADOR', 'ADMINISTRADOR');
INSERT INTO `permisos` VALUES ('2', 'CLIENTE', 'CLIENTE');
INSERT INTO `permisos` VALUES ('3', 'EMPLEADO', 'EMPLEADO');

-- ----------------------------
-- Table structure for persona
-- ----------------------------
DROP TABLE IF EXISTS `persona`;
CREATE TABLE `persona` (
  `id_persona` int(11) NOT NULL AUTO_INCREMENT,
  `apellidos_persona` varchar(50) NOT NULL,
  `nombres_persona` varchar(50) NOT NULL,
  `dni_persona` char(8) NOT NULL,
  `sexo_persona` char(1) NOT NULL,
  `fechanac_persona` date NOT NULL,
  PRIMARY KEY (`id_persona`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of persona
-- ----------------------------
INSERT INTO `persona` VALUES ('1', 'Jimenez', 'Pedro Administrador', '12345678', 'm', '1993-05-12');
INSERT INTO `persona` VALUES ('2', 'demo', 'demo', '88888888', 'm', '1990-10-17');
INSERT INTO `persona` VALUES ('3', 'cliente', 'cliente', '77777777', 'm', '1994-06-15');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of producto
-- ----------------------------
INSERT INTO `producto` VALUES ('1', 'HIELO TIPO CUBO (BOLSA)', '2.00', '', '');
INSERT INTO `producto` VALUES ('2', 'HIELO TIPO BLOQUE', '3.00', '', '');
INSERT INTO `producto` VALUES ('3', 'HIELO TIPO PELLET O TIPO RICE', '1.00', '', '');
INSERT INTO `producto` VALUES ('4', 'HIELO TIPO NUGGET', '2.00', '', '');
INSERT INTO `producto` VALUES ('5', 'HIELO TIPO SLICE O SLAB', '3.00', '', '');
INSERT INTO `producto` VALUES ('6', 'HIELO TIPO FRAPPÉ', '2.00', '', '');

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `id_permisos` int(11) NOT NULL,
  `id_persona` int(11) NOT NULL,
  `alias_usuario` varchar(50) NOT NULL,
  `password_usuario` varchar(50) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `id_permisos` (`id_permisos`),
  KEY `fk_usuario_persona1_idx` (`id_persona`),
  CONSTRAINT `fk_usuario_persona1` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_permisos`) REFERENCES `permisos` (`id_permisos`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of usuario
-- ----------------------------
INSERT INTO `usuario` VALUES ('1', '2', '2', 'demo', 'demo');
INSERT INTO `usuario` VALUES ('2', '1', '1', 'admin', 'admin');
INSERT INTO `usuario` VALUES ('4', '2', '3', 'cliente', 'cliente');

-- ----------------------------
-- Table structure for venta
-- ----------------------------
DROP TABLE IF EXISTS `venta`;
CREATE TABLE `venta` (
  `id_venta` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `tipo_compropago` char(1) NOT NULL,
  `fecha_venta` date NOT NULL,
  `total_venta` decimal(19,2) DEFAULT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `venta_ibfk_4` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of venta
-- ----------------------------
INSERT INTO `venta` VALUES ('1', '1', '1', '2015-11-27', '13.00');
INSERT INTO `venta` VALUES ('2', '1', '1', '2015-11-27', '15.00');
INSERT INTO `venta` VALUES ('3', '1', '0', '2015-11-27', '12.00');

-- ----------------------------
-- Procedure structure for sp_add_products
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_add_products`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_products`(IN `vid_venta` INT,IN `vid_producto` INT,IN `vcantidad_dtventa` INT)
BEGIN
DECLARE vprecio_producto decimal(19,2);
DECLARE vtotal_dtventa decimal(19,2);
DECLARE vtotal_dventa decimal(19,2);


SELECT precio_producto INTO vprecio_producto FROM producto WHERE id_producto=vid_producto;
SET vtotal_dtventa=vprecio_producto*vcantidad_dtventa;

INSERT INTO detalle_venta(id_venta, id_producto,cantidad_dtventa, total_dtventa) 
VALUES(vid_venta, vid_producto,vcantidad_dtventa, vtotal_dtventa);

SELECT SUM(total_dtventa) INTO vtotal_dventa FROM detalle_venta WHERE id_venta=vid_venta;

UPDATE venta SET total_venta=vtotal_dventa WHERE id_venta=vid_venta;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for sp_get_detail_sale
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_get_detail_sale`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_detail_sale`(IN `vid_usuario` INT)
BEGIN
  SELECT v.id_venta,p.id_producto,p.nombre_producto,p.imagen_producto,
  p.descripcion_producto,dt.cantidad_dtventa,p.precio_producto,v.fecha_venta,v.tipo_compropago,u.alias_usuario,u.id_usuario 
  FROM detalle_venta dt INNER JOIN venta v ON v.id_venta=dt.id_venta
  INNER JOIN producto p ON p.id_producto=dt.id_producto
  INNER JOIN usuario u ON u.id_usuario=v.id_usuario
  WHERE u.id_usuario=vid_usuario;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for sp_get_sale
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_get_sale`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_sale`(IN `vid_usuario` INT)
BEGIN
  SELECT v.id_venta,v.fecha_venta,v.tipo_compropago,v.total_venta,u.id_usuario,u.alias_usuario,
  count(p.id_producto) as nro_productos
  FROM detalle_venta dt INNER JOIN venta v ON v.id_venta=dt.id_venta
  INNER JOIN producto p ON p.id_producto=dt.id_producto
  INNER JOIN usuario u ON u.id_usuario=v.id_usuario
  WHERE u.id_usuario=vid_usuario
  GROUP BY v.id_venta;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for sp_get_salestotal
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_get_salestotal`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_salestotal`()
BEGIN
	SELECT v.id_venta,v.fecha_venta,v.tipo_compropago,v.total_venta,u.id_usuario,u.alias_usuario,
  count(p.id_producto) as nro_productos,pe.nombres_persona,pe.dni_persona
  FROM detalle_venta dt INNER JOIN venta v ON v.id_venta=dt.id_venta
  INNER JOIN producto p ON p.id_producto=dt.id_producto
  INNER JOIN usuario u ON u.id_usuario=v.id_usuario  
	INNER JOIN persona pe ON pe.id_persona=u.id_persona
  GROUP BY v.id_venta;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for sp_insert_sale
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_insert_sale`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_sale`(IN `vid_usuario` INT,IN `vtipo_compropago` char(1), IN `vfecha_venta` date,IN `vtotal_venta` decimal(19,2),
OUT `idventa_out` INT)
BEGIN
INSERT INTO venta(id_usuario, tipo_compropago,fecha_venta, total_venta) 
VALUES(vid_usuario, vtipo_compropago,vfecha_venta, vtotal_venta);
SELECT LAST_INSERT_ID() INTO idventa_out;
SELECT idventa_out;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for sp_login_user
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_login_user`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login_user`(IN `vusername` varchar(50),IN `vpassword` varchar(50))
BEGIN
  SELECT u.id_usuario,pe.id_persona,p.id_permisos,pe.nombres_persona, u.alias_usuario FROM usuario u INNER JOIN permisos p ON p.id_permisos=u.id_permisos
  INNER JOIN persona pe ON pe.id_persona=u.id_persona
  WHERE u.alias_usuario=vusername AND password_usuario=vpassword;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for sp_select_sale
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_select_sale`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_select_sale`(IN `vid_venta` INT)
BEGIN
  SELECT v.id_venta,p.id_producto,p.nombre_producto,p.descripcion_producto,dt.cantidad_dtventa,
  p.precio_producto,dt.total_dtventa,v.tipo_compropago FROM detalle_venta dt INNER JOIN venta v ON v.id_venta=dt.id_venta
  INNER JOIN producto p ON p.id_producto=dt.id_producto
  WHERE v.id_venta=vid_venta;
END
;;
DELIMITER ;
