<?php defined('BASEPATH') OR exit('No direct script access allowed');

class venta extends CI_Controller {

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
			$this->load->view('venta/venta.html');
			$this->load->view('principal/footer.html');
			break;

			case FALSE: 
			$this->load->view('principal/header.html');
			$this->load->view('login/login.html');
			$this->load->view('principal/footer.html');
			break;
		}
	}


}
