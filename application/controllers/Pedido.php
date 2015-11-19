<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Pedido extends CI_Controller {

	public function __construct(){  
		parent::__construct();     
		// date_default_timezone_set('America/Lima'); 
		$this->load->model('pedido_model');
	}

	public function index()
	{
		switch ($this->session->userdata('login')){

			case TRUE:    
			$this->load->view('principal/header.html');
			$this->load->view('principal/navbar.html');
			$this->load->view('principal/menu.html');
			$this->load->view('pedido/pedido.html');
			$this->load->view('pedido/modal_pedido.html');
			$this->load->view('principal/footer.html');
			break;

			case FALSE: 
			$this->load->view('principal/header.html'); 
			$this->load->view('login/login.html');
			$this->load->view('principal/footer.html');
			break;
		}
	}
	public function registrar_venta()
	{
		$json = file_get_contents('php://input');
		$data = json_decode($json,TRUE);
		$registrar_venta=$this->pedido_model->registrar_venta($data);
		echo json_encode($registrar_venta);
	}
 
	public function agregar_producto()
	{
		$json = file_get_contents('php://input');
		$data = json_decode($json,TRUE);
		$count=count($data['all_products']);	

		for ($i = 0; $i < $count; $i++)
		{
			$agregar_producto=$this->pedido_model->agregar_producto($data['id_venta'][0],$data['all_products'][$i],$data['cant_products'][$i]);
	  	}
	  	echo json_encode(1);
	  	
	}
	public function listar_productos()
	{
		$listar_productos=$this->pedido_model->listar_productos();
    	echo json_encode($listar_productos);
	}

	public function listar_ventas()
	{
		$listar_ventas=$this->pedido_model->listar_ventas();
    	echo json_encode($listar_ventas);
	}
}