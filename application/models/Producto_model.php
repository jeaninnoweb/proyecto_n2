<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Producto_model extends CI_Model {


 public function registrar_producto($data)
  {
    $nombre_producto=$data['nombre_producto'];
    $descripcion_producto=$data['descripcion_producto'];
    $precio_producto=$data['precio_producto'];
    $query=$this->db->query("CALL sp_insert_product('$nombre_producto','$descripcion_producto',$precio_producto);");   
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


  // public function registrar_producto($data)
  // {
  //   $nombre_producto=$data['nombre_producto'];
  //   $descripcion_producto=$data['descripcion_producto'];
  //   $precio_producto=$data['precio_producto'];

  //   $query=$this->db->query("CALL sp_insert_product('$nombre_producto','$descripcion_producto',$precio_producto);");
  // }

  // public function consultar_venta($data)
  // {
  //   $id_venta=$data['id_venta'];
  //   $query=$this->db->query("CALL sp_select_sale($id_venta);");

  //   if ($query->num_rows()>0) 
  //   {
  //     return $query->result();
  //   }
  //   else
  //   {
  //     return false;
  //   } 
  // }
}

   
