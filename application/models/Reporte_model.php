<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Reporte_model extends CI_Model {

  public function report_products()
  {
    $query=$this->db->query("CALL sp_report_products();");

    if ($query->num_rows()>0) 
    {
      return $query->result();
    }
    else
    {
      return false;
    }   
  }

  // public function registrar_ventam($data)
  // {
  //   $fecha_venta=$data['fecha_venta'];
  //   $tipo_compropago=$data['tipo_compropago'];
  //   $nom_compropago=$data['nom_compropago'];
  //   $tipo_docidentidad=$data['tipo_docidentidad'];
  //   $nro_docidentidad=$data['nro_docidentidad'];
  //   $total_venta=$data['total_venta'];    
  //   $id_usuario=$this->session->userdata('id_usuario');

  //   $query=$this->db->query("CALL sp_insert_salem($id_usuario,'$tipo_compropago','$fecha_venta',$total_venta,
  //   '$nom_compropago', $tipo_docidentidad, $nro_docidentidad,@idventa_out);");

  //   if ($query->num_rows()==1)
  //   {
  //    return $query->row();
  //   }
  //   else
  //   {
  //    return false; 
  //   }
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

   
