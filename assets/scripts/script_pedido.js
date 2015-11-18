//Inicianilation Page load event
$(document).ready(page_pedido);

var $btn_modal_nuevopedido=$('#btn-modal-nuevopedido');
var $modal_pedido=$('#modal_pedido');
var $table_add_product=$('#table-add-product');
var $btn_guardar_pedido=$('#btn-guardar-pedido');
var $divproductos=$('#divproductos');


function page_pedido(){
	$btn_modal_nuevopedido.on('click',fnc_modal_nuevopedido);
	$table_add_product.DataTable({"bPaginate": true, "bLengthChange": false, "bFilter": false, "bInfo": false, "bAutoWidth": false});
    $modal_pedido.find('.modal-dialog').css('width','700px');
    $btn_guardar_pedido.on('click',fnc_guardar_pedido);
}

function fnc_modal_nuevopedido () {
	$modal_pedido.modal('show');
	listar_produtos ();	
}

function fnc_guardar_pedido () {
	var all_products=[];
	var cant_products=[];
	var select_product=$('.select-product').length;
	var $cant_product=$('.cant_product');
	var productid;
	var productcant;
	var data={};

	for (var i = 0; i < select_product; i++) {

		if($('.select-product').eq(i).is(':checked')){

			productid=$('.select-product').eq(i).val();			
		    all_products.push(productid);
			productcant=$cant_product.eq(i).val();
			cant_products.push(productcant);
		}
	};

	data.all_products=all_products;
	data.cant_products= cant_products;

	  $.ajax({
	  url: "agregar_producto",
	  type:'POST',
	  data: JSON.stringify(data),
	  contentType: "application/json; charset =utf-8",
	  dataType: "json",
	  success: function(resp)
	  {
	    // fn_msg_action('MENSAJE DE REGISTRO DE COLABORADOR',resp[0].MessageResult,resp[0].MessageValue);
	    // $('#modal-participante').modal('hide');

	   $modal_pedido.modal('hide');
	  }
	}); 	
}

function listar_produtos () {

	$.getJSON("listar_productos", function (data) {      
	    
	      $.each(data, function (i, item) {
	      $divproductos.append('<div class="col-md-3">'
										+'<div style="width:100%;height:80px;background:#333">'
											+'<label style="width:100%;" class="form-checkbox form-icon btn btn-primary">'
											+'<input type="checkbox" class="select-product" value="1"> Option 1</label>'
										+'</div>'
										+'<input type="text" placeholder="Cantidad" class="form-control cant_product">'
									+'</div>');
	      });
	});
}


