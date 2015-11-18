<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Pedido_model extends CI_Model {

  public function registrar_venta($data)
  {
    $fecha_venta=$data['fecha_venta'];
    $tipo_compropago=$data['tipo_compropago'];
    $total_venta=$data['total_venta'];
    $id_usuario=$this->session->userdata('id_usuario');
    $query=$this->db->query("CALL sp_insert_sale($id_usuario,'$fecha_venta','$tipo_compropago',$total_venta);");
  }

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

   
