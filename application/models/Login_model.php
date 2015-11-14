<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Login_model extends CI_Model {

  public function validarlogin($data)
  {
    $this->db->select('*');
    $this->db->from('usuario u');
    $this->db->join('permisos p', 'p.id_permisos = u.id_permisos');         
    $this->db->where('u.alias_usuario', $data['username']);
    $this->db->where('u.password_usuario', $data['password']);
    $query = $this->db->get();                   

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

   
