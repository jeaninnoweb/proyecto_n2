<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Envio_model extends CI_Model {


  // public function agregar_producto($id_venta,$id_producto,$cant_producto)
  // {
  //   $query=$this->db->query("CALL sp_add_products($id_venta,$id_producto,$cant_producto);");   
  // }

  public function listar_envios()
  {
    $this->db->select('*');
    $this->db->from('envio'); 
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
  public function listar_envios2()
  {
    $id_usuario=$this->session->userdata('id_usuario');
    $query=$this->db->query("CALL sp_get_envio($id_usuario);");

    if ($query->num_rows()>0) 
    {
      return $query->result();
    }
    else
    {
      return false;
    }   
  }
  // public function listar_ventastotales()
  // {   
  //   $query=$this->db->query("CALL sp_get_salestotal();");

  //   if ($query->num_rows()>0) 
  //   {
  //     return $query->result();
  //   }
  //   else
  //   {
  //     return false;
  //   }   
  // }

  public function registrar_envio($data)
  {
    $id_venta=$data['id_venta'];
    $origen=$data['origen'];
    $destino=$data['destino'];
    $hora=$data['hora'];   

    $query=$this->db->query("CALL sp_insert_envio('$origen','$destino','$hora',$id_venta);");
   
  }

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

   
