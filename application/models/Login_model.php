<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Login_model extends CI_Model {

  public function validarlogin($data)
  {
    $username=$data['username'];
    $password=$data['password'];

    $query=$this->db->query("CALL sp_login_user('$username','$password');");

    if ($query->num_rows()==1)
    {
     return $query->row();
    }

    else
    {
     return false; 
    }  
  }
}

   
