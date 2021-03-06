<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/*
| -------------------------------------------------------------------------
| URI ROUTING
| -------------------------------------------------------------------------
| This file lets you re-map URI requests to specific controller functions.
|
| Typically there is a one-to-one relationship between a URL string
| and its corresponding controller class/method. The segments in a
| URL normally follow this pattern:
|
|	example.com/class/method/id/
|
| In some instances, however, you may want to remap this relationship
| so that a different class/function is called than the one
| corresponding to the URL.
|
| Please see the user guide for complete details:
|
|	http://codeigniter.com/user_guide/general/routing.html
|
| -------------------------------------------------------------------------
| RESERVED ROUTES
| -------------------------------------------------------------------------
|
| There are three reserved routes:
|
|	$route['default_controller'] = 'welcome';
|
| This route indicates which controller class should be loaded if the
| URI contains no data. In the above example, the "welcome" class
| would be loaded.
|
|	$route['404_override'] = 'errors/page_missing';
|
| This route will tell the Router which controller/method to use if those
| provided in the URL cannot be matched to a valid route.
|
|	$route['translate_uri_dashes'] = FALSE;
|
| This is not exactly a route, but allows you to automatically route
| controller and method names that contain dashes. '-' isn't a valid
| class or method name character, so it requires translation.
| When you set this option to TRUE, it will replace ALL dashes in the
| controller and method URI segments.
|
| Examples:	my-controller/index	-> my_controller/index
|		my-controller/my-method	-> my_controller/my_method
*/
$route['default_controller'] = 'Login';
$route['404_override'] = '';
$route['translate_uri_dashes'] = FALSE;
//________________________________________________________________________________________________________________________________________________________________

$route['login'] = "login/login";
$route['logout'] = "login/logout";
$route['venta'] = "venta/index";
$route['pedido'] = "pedido/index";
$route['producto'] = "producto/index";
$route['usuario'] = "usuario/index";
$route['registrar_venta'] = "pedido/registrar_venta";
$route['agregar_producto'] = "pedido/agregar_producto";
$route['listar_productos'] = "pedido/listar_productos";
$route['listar_ventas'] = "pedido/listar_ventas";
$route['consultar_venta'] = "pedido/consultar_venta";
$route['listar_ventastotales'] = "venta/listar_ventastotales";
$route['registrar_ventam'] = "venta/registrar_ventam";
$route['registrar_producto'] = "producto/registrar_producto";
$route['listar_usuario'] = "usuario/listar_usuario";
$route['listar_permisos'] = "usuario/listar_permisos";
$route['reportes'] = "reportes/index";
$route['reportes2'] = "reportes/reportes2";
$route['report_products'] = "reportes/report_products";
$route['report_clientes'] = "reportes/report_clientes";
$route['envio'] = "envio/index";
$route['registrar_envio'] = "envio/registrar_envio";
$route['listar_envios'] = "envio/listar_envios";
$route['listar_envios2'] = "envio/listar_envios2";