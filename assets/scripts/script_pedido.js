//Inicianilation Page load event
$(document).ready(page_pedido);

var $btn_modal_nuevopedido=$('#btn-modal-nuevopedido');
var $modal_pedido=$('#modal_pedido');
var $modal_verpedido=$('#modal_verpedido');
var $btn_guardar_pedido=$('#btn-guardar-pedido');
var $divproductos=$('#divproductos');
var $table_sale=$('#datable-sale').DataTable({"responsive": true, "language": {"paginate": {"previous": '<i class="fa fa-angle-left"></i>', "next": '<i class="fa fa-angle-right"></i>'} }, "dom": '<"newtoolbar">frtip'});
var $table_sale2=$('#datable-sale2').DataTable({"responsive": true,"bPaginate": false, "bSort": false,"bFilter":false,"bInfo" : false});
var $select_compropago=$('#select-compropago');
var $tcompropago=$('#tcompropago');

function page_pedido()
{
	listar_ventas ();
	$select_compropago.chosen({ width: '100%' });
	$select_compropago.on('change',fbc_change_comprobante);	
	$('.modal').find('.modal-dialog').css('width','700px');
	$btn_modal_nuevopedido.on('click',fnc_modal_nuevopedido);    
    $btn_guardar_pedido.on('click',fnc_guardar_pedido);  
    $(document).on('click','.modal_ver_pedido',fnc_modal_verpedido);
}
//____________________________________________________________________________________________________________________________________________________________________________________________________

function fnc_modal_verpedido () {
	$table_sale2.row().clear().draw( false );
	$modal_verpedido.modal('show');
	var id_venta=$(this).attr('data-id');
	var data={};
	data.id_venta=id_venta;
	$.ajax({
		url: "consultar_venta",
		type:'POST',
		data: JSON.stringify(data),
		contentType: "application/json; charset =utf-8",
		dataType: "json",
		success: function(resp)
		{
			var tcompro_pago,tdociden;
			if(resp[0].tipo_compropago==1){tcompro_pago='FACTURA'}
			else{tcompro_pago='BOLETA'}	

			if(resp[0].tipo_docidentidad==1){tdociden='RUC'}
			else{tdociden='DNI'}	

			$tcompropago.html('<div class="row" ><div class="col-md-4"><b>COMPROBANTE PAGO:</b> '+tcompro_pago+'</div><div class="col-md-1"> Nº '+resp[0].id_venta+'</div>'
				+'<div>'+tdociden+'</div>'
				+'<div>'+resp[0].nro_docidentidad+'</div></div>');
			var total_venta=0;
			for (var i=0;i<resp.length;i++ ) {
				$table_sale2.row.add([resp[i].id_producto,resp[i].nombre_producto,resp[i].descripcion_producto,
				resp[i].cantidad_dtventa,'S/. '+resp[i].precio_producto,'S/. '+resp[i].total_dtventa
				]).draw(false);	

				total_venta=total_venta+parseFloat(resp[i].total_dtventa);
			};

			$('#total').html('TOTAL: S/. '+parseFloat(total_venta).toFixed(2));
		}
	});
}

function fnc_modal_nuevopedido () {
	$modal_pedido.modal('show');
	$select_compropago.val("").trigger("chosen:updated");
	$divproductos.empty();
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
	data.tipo_compropago=$select_compropago.val();
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

function fbc_change_comprobante () {
	listar_produtos ();	
}

function listar_ventas () {	
	$.getJSON("listar_ventas", function (data) {      
			$table_sale.row().clear().draw( false );
			var tcompro_pago;
			$.each(data, function (i, item) {	
				if(item.tipo_compropago==1){tcompro_pago='FACTURA'}
				else{tcompro_pago='BOLETA'}		
				$table_sale.row.add([item.id_venta,item.fecha_venta,tcompro_pago,item.nro_productos,item.total_venta,
				'<a href="javascript:void(0);" data-id="'+item.id_venta+'" class="btn btn-primary btn-xs modal_ver_pedido" ><i class="fa fa-bars" style="font-size:15px;"></i></a>'
				+'&nbsp;<a href="javascript:void(0);" data-id="'+item.id_venta+'" class="btn btn-primary btn-xs" ><i class="fa fa-pencil" style="font-size:15px;"></i></a>'
                +'&nbsp;<a data-id="'+item.id_venta+'" class="btn btn-danger btn-xs"><i class="fa fa-remove" style="font-size:15px;"></i> </a>']).draw(false);				
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


