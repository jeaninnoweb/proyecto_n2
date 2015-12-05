<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Producto extends CI_Controller {

	public function __construct(){  
		parent::__construct();     
		// date_default_timezone_set('America/Lima'); 
		$this->load->model('producto_model');
	}

	public function index()
	{
		$idpermisos=$this->session->userdata('id_permisos');
		
		switch ($this->session->userdata('login')){

			case TRUE:    
			$this->load->view('principal/header.html');
			$this->load->view('principal/navbar.html');
			switch ($idpermisos) {
				case 1:
					$this->load->view('principal/menu.html');
					break;
				
				case 2:
					$this->load->view('principal/menu-cliente.html');
					break;
			}
			$this->load->view('producto/producto.html');
			$this->load->view('producto/modal_producto.html');
			$this->load->view('principal/footer.html');
			break;

			case FALSE: 
			$this->load->view('principal/header.html');
			$this->load->view('login/login.html');
			$this->load->view('principal/footer.html');
			break;
		}
	}
	public function listar_productos()
	{
		$listar_productos=$this->producto_model->listar_productos();
    	echo json_encode($listar_productos);
	}

	public function registrar_producto()
	{
		$json = file_get_contents('php://input');
		$data = json_decode($json,TRUE);
		$registrar_producto=$this->producto_model->registrar_producto($data);
		echo json_encode(1);
	}
}
