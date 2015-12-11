<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Envio extends CI_Controller {

	public function __construct(){  
		parent::__construct();     
		// date_default_timezone_set('America/Lima'); 
		$this->load->model('envio_model');
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
					$this->load->view('envio/envio.html');
					$this->load->view('envio/modal_envio.html');
					break;
				
				case 2:
					$this->load->view('principal/menu-cliente.html');
					$this->load->view('envio/envio-cliente.html');					
					break;
					case 3:
					$this->load->view('principal/menu-cliente.html');
					$this->load->view('envio/envio-cliente.html');					
					break;
					case 4:
					$this->load->view('principal/menu-cliente.html');
					$this->load->view('envio/envio-cliente.html');					
					break;
			}			
			$this->load->view('principal/footer.html');
			break;

			case FALSE: 
			$this->load->view('principal/header.html');
			$this->load->view('login/login.html');
			$this->load->view('principal/footer.html');
			break;
		}
	}
	public function listar_envios()
	{
		$listar_envios=$this->envio_model->listar_envios();
    	echo json_encode($listar_envios);
	}
	public function listar_envios2()
	{
		$listar_envios2=$this->envio_model->listar_envios2();
    	echo json_encode($listar_envios2);
	}
	public function registrar_envio()
	{
		$json = file_get_contents('php://input');
		$data = json_decode($json,TRUE);
		$registrar_envio=$this->envio_model->registrar_envio($data);
		echo json_encode(1);
	}


}
