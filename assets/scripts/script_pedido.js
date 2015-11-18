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
	var data2={};

	for (var i = 0; i < select_product; i++) {

		if($('.select-product').eq(i).is(':checked')){

			productid=$('.select-product').eq(i).val();			
		    all_products.push(productid);
			productcant=$cant_product.eq(i).val();
			cant_products.push(productcant);
		}
	};

	data.fecha_venta=get_today();
	data.tipo_compropago='1';
	data.total_venta=0;

	data2.all_products=all_products;
	data2.cant_products= cant_products;
	

	$.ajax({
		url: "registrar_venta",
		type:'POST',
		data: JSON.stringify(data),
		contentType: "application/json; charset =utf-8",
		dataType: "json",
		success: function(resp)
		{
			var id_venta=resp.idventa_out;
			data2.id_venta= id_venta;
			$.ajax({
				url: "agregar_producto",
				type:'POST',
				data: JSON.stringify(data),
				contentType: "application/json; charset =utf-8",
				dataType: "json",
				success: function(resp)
				{
					$modal_pedido.modal('hide');
				}
			}); 
		}
	}); 		
}

function listar_produtos () {

	$.getJSON("listar_productos", function (data) {      
		$divproductos.empty();
		$.each(data, function (i, item) {
			$divproductos.append('<div class="col-md-6" style="margin-bottom:20px;">'
				+'<div style="width:100%;height:100%;background:#333">'
				+'<label style="width:100%;" class="form-icon btn btn-primary">'
				+'<input type="checkbox" class="select-product" value="'+item.id_producto+'">'+item.nombre_producto+'</label>'
				+'<img src="assets/img/productos/hielo.jpg" style="height:80px;">&nbsp;&nbsp;<span style="color:#fff">PRECIO S/.'+item.precio_producto+'<span></div>'
				+'<input type="text" style="background:#f0f8ff" placeholder="Cantidad" class="form-control cant_product">'
				+'</div>');
		});
	});
}

function get_today(){

  var d = new Date(); var meses=""; var dias=""; var horas=""; var minutos=""; var date = "";
  meses = d.getMonth()+1;  if (meses<10) {  meses = "0"+meses; };
  dias = d.getDate();  if (dias<10) {  dias = "0"+dias;  }; 
  date = d.getFullYear()+"-"+ meses + "-" +dias;
  return date;
}


