<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Reportes extends CI_Controller {

	public function __construct(){  
		parent::__construct();     
		// date_default_timezone_set('America/Lima'); 
		$this->load->model('reporte_model');
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
					case 3:
				$this->load->view('principal/menu-cliente.html');
				break;
				
				case 4:
				$this->load->view('principal/menu.html');
				break;
			}
			$this->load->view('reportes/rbar-producto.html');			
			$this->load->view('principal/footer.html');
			break;

			case FALSE: 
			$this->load->view('principal/header.html');
			$this->load->view('login/login.html');
			$this->load->view('principal/footer.html');
			break;
		}
	}
	public function report_products()
	{
		$json = file_get_contents('php://input');
	 	$data = json_decode($json,TRUE);
		$report_products=$this->reporte_model->report_products($data);
    	echo json_encode($report_products);
	}

	public function reportes2()
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
			$this->load->view('reportes/rbar-cliente.html');			
			$this->load->view('principal/footer.html');
			break;

			case FALSE: 
			$this->load->view('principal/header.html');
			$this->load->view('login/login.html');
			$this->load->view('principal/footer.html');
			break;
		}
	}

	public function report_clientes()
	{
		$json = file_get_contents('php://input');
	 	$data = json_decode($json,TRUE);
		$report_clientes=$this->reporte_model->report_clientes($data);
    	echo json_encode($report_clientes);
	}


}
