<?php

      defined('BASEPATH') OR exit('No Script Direct');

      class Api extends CI_Controller{
      	function __construct(){
      		parent:: __construct();
      		date_default_timezone_set('Asia/Jakarta');
      		error_reporting(E_ALL);
      		ini_set('Display Error', 1);
      	}

      	function getNews(){
                  $idUser = $this->input->post('iduser');
                  $this->db->order_by('date_news', 'DESC');
                  $this->db->where('id_user', $idUser);
                  $query = $this->db->get('tb_news');
                  //$query = $this->db->get('tb_news');
                  if($idUser != null || $idUser != ""){
                        if($query -> num_rows() > 0){
                              $data['message'] = "Successfully Get Data News With Id";
                              $data['status'] = 200;
                              $data['article'] = $query->result();
                        }else{
                              $data['message'] = "Failed Get Data News";
                              $data['status'] = 400;
                        }
                  } else {
                         $q = $this->db->get('tb_news');
                         if($q -> num_rows() > 0){
                              $data['message'] = "Successfully Get Data News Without Id";
                              $data['status'] = 200;
                              $data['article'] = $q->result();
                        }else{
                              $data['message'] = "Failed Get Data News";
                              $data['status'] = 400;
                        }

                  }
                  echo json_encode($data);
            }
      }
?>