//Inicianilation Page load event
$(document).ready(page_pedido);

var $btn_modal_nuevopedido=$('#btn-modal-nuevopedido');
var $modal_pedido=$('#modal_pedido');
var $modal_verpedido=$('#modal_verpedido');
// var $table_add_product=$('#demo-dt-addrow').DataTable({"bPaginate": true, "bLengthChange": false, "bFilter": false, "bInfo": false, "bAutoWidth": false});
var $btn_guardar_pedido=$('#btn-guardar-pedido');
var $divproductos=$('#divproductos');
var datatable_sale;
var $table_sale=$('#datable-sale').DataTable({"responsive": true, "language": {"paginate": {"previous": '<i class="fa fa-angle-left"></i>', "next": '<i class="fa fa-angle-right"></i>'} }, "dom": '<"newtoolbar">frtip'});
var $table_sale2=$('#datable-sale2').DataTable({"responsive": true,"bPaginate": false, "bSort": false,"bFilter":false,"bInfo" : false});

function page_pedido(){

	listar_ventas ();
	$btn_modal_nuevopedido.on('click',fnc_modal_nuevopedido);
    $('.modal').find('.modal-dialog').css('width','700px');
    $btn_guardar_pedido.on('click',fnc_guardar_pedido);  
    $(document).on('click','.modal_ver_pedido',fnc_modal_verpedido);
}

function fnc_modal_verpedido () {
	$modal_verpedido.modal('show');
	var venta_id=$(this).attr('data-id');
	var data={};
	data.venta_id=venta_id;
	$.ajax({
		url: "consultar_venta",
		type:'POST',
		data: JSON.stringify(data),
		contentType: "application/json; charset =utf-8",
		dataType: "json",
		success: function(resp)
		{
		}
	});
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
			data2.all_products=all_products;
			data2.cant_products= cant_products;

			$.ajax({
				url: "agregar_producto",
				type:'POST',
				data: JSON.stringify(data2),
				contentType: "application/json; charset =utf-8",
				dataType: "json",
				success: function(resp)
				{
					$modal_pedido.modal('hide');
					listar_ventas ();
				}
			}); 
		}
	}); 		
}
function listar_ventas () {	
	var nro=1;
	$.getJSON("listar_ventas", function (data) {      
			$table_sale.row().clear().draw( false );
			$.each(data, function (i, item) {				
				$table_sale.row.add([nro,item.id_venta,item.fecha_venta,item.tipo_compropago,item.nro_productos,item.total_venta,
				'<a href="javascript:void(0);" data-id="'+item.id_venta+'" class="btn btn-primary btn-xs modal_ver_pedido" ><i class="fa fa-bars" style="font-size:15px;"></i></a>'
				+'&nbsp;<a href="javascript:void(0);" data-id="'+item.id_venta+'" class="btn btn-primary btn-xs" ><i class="fa fa-pencil" style="font-size:15px;"></i></a>'
                +'&nbsp;<a data-id="'+item.id_venta+'" class="btn btn-danger btn-xs"><i class="fa fa-remove" style="font-size:15px;"></i> </a>']).draw(false);
				nro++;
			});
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


