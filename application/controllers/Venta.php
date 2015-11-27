<?php defined('BASEPATH') OR exit('No direct script access allowed');

class venta extends CI_Controller {

	public function __construct(){  
		parent::__construct();     
		// date_default_timezone_set('America/Lima'); 
		$this->load->model('venta_model');
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
			$this->load->view('venta/venta.html');
			$this->load->view('venta/modal_venta.html');
			$this->load->view('principal/footer.html');
			break;

			case FALSE: 
			$this->load->view('principal/header.html');
			$this->load->view('login/login.html');
			$this->load->view('principal/footer.html');
			break;
		}
	}
	public function listar_ventastotales()
	{
		$listar_ventastotales=$this->venta_model->listar_ventastotales();
    	echo json_encode($listar_ventastotales);
	}


}
