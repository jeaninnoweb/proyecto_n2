<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Login extends CI_Controller {

	public function __construct(){  
		parent::__construct();     
		date_default_timezone_set('America/Lima'); 
		$this->load->model('login_model');
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
			
			$this->load->view('principal/index.html');
			$this->load->view('principal/footer.html');
			break;

			case FALSE:    
			
			$this->load->view('principal/header.html');
			$this->load->view('login/login.html');
			$this->load->view('principal/footer.html');
			break;
		}
	}

	public function login()
	{
		$json = file_get_contents('php://input');
		$data = json_decode($json,TRUE);
		$login = $this->login_model->validarlogin($data);

		if($login==TRUE){
			$var= array(
				'id_usuario' => $login->id_usuario,
				'id_permisos' => $login->id_permisos,
				'nombres_persona' => $login->nombres_persona,
				'alias_usuario' => $login->alias_usuario,
				'login' => TRUE);
			$this->session->set_userdata($var);
			echo  json_encode($var);
		}else{
			$var ='No existe usuario';
			echo  json_encode($var);
		}
	}

	public function logout()
	{ 
		$this->session->sess_destroy();           
		echo '<script>
		sessionStorage.clear();
		window.location.href="'.base_url().'"
	</script>';
} 
}
