<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Principal extends CI_Controller {

   // public function __construct(){  
   // parent::__construct();     
   //  date_default_timezone_set('America/Lima'); 
   //  }

	public function index()
	{
		$this->load->view('principal/header.html');
		$this->load->view('login/login.html');
		$this->load->view('principal/footer.html');
	}

	public function login()
	{
// 		 $username = json_encode($this->input->post('username'));
// // header('Content-Type: application/json');
// 		// $tmp = json_encode($username);

// 		// $tmp[] = json_decode(array(''=>$this->input->post('username'));

// 		print_r($username);
		// $Data = $this->input->post('username');
  //       var_dump(json_decode($Data, true));

        $json = file_get_contents('php://input');
		$data = json_decode($json); 
		
		print_r($data);

// $Data = json_encode(file_get_contents('php://input'));
//          echo $Data;
	}
}
