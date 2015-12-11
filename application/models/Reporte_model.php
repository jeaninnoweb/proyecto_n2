<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Reporte_model extends CI_Model {

  public function report_products($data)
  {
     $anio=$data['anio'];
     $mes=$data['mes'];
    $query=$this->db->query("CALL sp_report_products($anio,$mes);");

    if ($query->num_rows()>0) 
    {
      return $query->result();
    }
    else
    {
      return false;
    }   
  }

  public function report_clientes($data)
  {
     $anio=$data['anio'];
     $mes=$data['mes'];
    $query=$this->db->query("CALL sp_report_clientes($anio,$mes);");

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

   
