//================================
//==> DOCUMENT READY PAGE_PEDIDO
//================================
$(document).ready(init_producto);

//=================================
//==> INICIANILIZACIÓN DE VARIABLES
//=================================
var $btn_modal_addproducto=$('#btn-modal-addproducto');
var $modal_producto=$('#modal_producto');
var $btn_guardar_producto=$('#btn-guardar-producto');
var $table_producto=$('#data-table-producto').DataTable({"responsive": true, "language": {"paginate": {"previous": '<i class="fa fa-angle-left"></i>', "next": '<i class="fa fa-angle-right"></i>'} }, "dom": '<"newtoolbar">frtip'});
var $txt_nombrep=$('#txt_nombrep');
var $txt_descp=$('#txt_descp');
var $txt_preciop=$('#txt_preciop');


//================================
//==> FNC PAGE PEDIDO
//================================
function init_producto()
{
	listar_productos ();

	/*2º*/$btn_modal_addproducto.on('click',fnc_modal_addproducto);
 /*3º*/$btn_guardar_producto.on('click',fnc_guardar_producto); 
	// 4º$select_compropago.on('change',fnc_change_comprobante);	        
}
//____________________________________________________________________________________________________________________________________________________________________________________________________


//================================
//==>2º MODAL VER NUEVO PEDIDO
//================================
function fnc_modal_addproducto ()
{
	$modal_producto.modal('show');
	$('.rproducto').val('');
} 
function fnc_guardar_producto () {	
	
	var data={};
	data.nombre_producto=$txt_nombrep.val();
	data.descripcion_producto=$txt_descp.val();
	data.precio_producto=$txt_preciop.val();

	$.ajax({
		url: "registrar_producto",
		type:'POST',
		data: JSON.stringify(data),
		contentType: "application/json; charset =utf-8",
		dataType: "json",
		success: function(resp)
		{	
			$modal_producto.modal('hide');	
			listar_productos ();	
		}
	}); 	
}
//____________________________________________________________________________________________________________________________________________________________________________________________________

//================================
//==> FNC LISTAR PRODUCTO AL DATATABLE
//================================
function listar_productos ()
{
	$.getJSON("listar_productos", function (data){ 

			$table_producto.row().clear().draw( false );
			

			$.each(data, function (i, item) {
				
				$table_producto.row.add([item.id_producto,item.nombre_producto,item.descripcion_producto,'S/. '+item.precio_producto,
				'<a href="javascript:void(0);" data-id="'+item.id_producto+'" class="btn btn-primary btn-xs modal_ver_pedido" ><i class="fa fa-bars" style="font-size:15px;"></i></a>'
				+'&nbsp;<a href="javascript:void(0);" data-id="'+item.id_producto+'" class="btn btn-primary btn-xs" ><i class="fa fa-pencil" style="font-size:15px;"></i></a>'
                +'&nbsp;<a data-id="'+item.id_producto+'" class="btn btn-danger btn-xs"><i class="fa fa-remove" style="font-size:15px;"></i> </a>']).draw(false);				
			});
	});
}

//____________________________________________________________________________________________________________________________________________________________________________________________________