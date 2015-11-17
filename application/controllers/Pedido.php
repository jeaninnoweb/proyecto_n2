<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Pedido extends CI_Controller {

	public function __construct(){  
		parent::__construct();     
		// date_default_timezone_set('America/Lima'); 
		// $this->load->model('login_model');
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

	public function agregar_producto()
	{
		$json = file_get_contents('php://input');
		$data = json_decode($json,TRUE);
		$login = $this->login_model->validarlogin($data);
	}


}
