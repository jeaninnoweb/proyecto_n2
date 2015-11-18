<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Pedido_model extends CI_Model {

  public function agregar_producto($id_producto,$cant_producto)
  {
    $query=$this->db->query("CALL sp_add_products('$id_producto','$cant_producto');");
  }

  public function listar_productos()
  {
    $this->db->select('*');
    $this->db->from('producto'); 
    $query = $this->db->get();

    if ($query->num_rows()>0)
    {
      return $query->result();
    }
    else
    {
      return false;
    }  
  }
}

   
