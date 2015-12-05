<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Usuario extends CI_Controller {

	public function __construct(){  
		parent::__construct();     
		// date_default_timezone_set('America/Lima'); 
		$this->load->model('usuario_model');
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
			$this->load->view('usuario/usuario.html');
			$this->load->view('usuario/modal_usuario.html');
			$this->load->view('principal/footer.html');
			break;

			case FALSE: 
			$this->load->view('principal/header.html');
			$this->load->view('login/login.html');
			$this->load->view('principal/footer.html');
			break;
		}
	}
	public function listar_usuario()
	{
		$listar_usuario=$this->usuario_model->listar_usuario();
    	echo json_encode($listar_usuario);
	}

	public function listar_permisos()
	{
		$listar_permisos=$this->usuario_model->listar_permisos();
    	echo json_encode($listar_permisos);
	}

	// public function registrar_ventam()
	// {
	// 	$json = file_get_contents('php://input');
	// 	$data = json_decode($json,TRUE);
	// 	$registrar_ventam=$this->venta_model->registrar_ventam($data);
	// 	echo json_encode($registrar_ventam);
	// }


}
