<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Pedido_model extends CI_Model {

  public function registrar_venta($data)
  {
    $fecha_venta=$data['fecha_venta'];
    $tipo_compropago=$data['tipo_compropago'];
    $total_venta=$data['total_venta'];
    $id_usuario=$this->session->userdata('id_usuario');
    $query=$this->db->query("CALL sp_insert_sale($id_usuario,'$tipo_compropago','$fecha_venta',$total_venta,@idventa_out);");

    if ($query->num_rows()==1)
    {
     return $query->row();
    }
    else
    {
     return false; 
    }
  }

  public function agregar_producto($id_venta,$id_producto,$cant_producto)
  {
    $query=$this->db->query("CALL sp_add_products($id_venta,$id_producto,$cant_producto);");   
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
  public function listar_ventas()
  {
    $id_usuario=$this->session->userdata('id_usuario');
    $query=$this->db->query("CALL sp_get_sale($id_usuario);");

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

   
