<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Pedido_model extends CI_Model {

  public function agregar_producto($id_producto,$cant_producto)
  {
    // $id_producto=$data['all_products'];
    // $cant_producto=$data1['cant_products'];

    $query=$this->db->query("CALL sp_add_products('$id_producto','$cant_producto');");

    // if ($query->num_rows()==1)
    // {
    //  return $query->row();
    // }

    // else
    // {
    //  return false; 
    // }  
  }
}

   
