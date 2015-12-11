//================================
//==> DOCUMENT READY PAGE_PEDIDO
//================================
$(document).ready(init_envio);

//=================================
//==> INICIANILIZACIÓN DE VARIABLES
//=================================

var $table_envio=$('#data-table-envio').DataTable({"responsive": true, "language": {"paginate": {"previous": '<i class="fa fa-angle-left"></i>', "next": '<i class="fa fa-angle-right"></i>'} }, "dom": '<"newtoolbar">frtip'});
var $table_envio2=$('#data-table-envio2').DataTable({"responsive": true, "language": {"paginate": {"previous": '<i class="fa fa-angle-left"></i>', "next": '<i class="fa fa-angle-right"></i>'} }, "dom": '<"newtoolbar">frtip'});
var $btn_modal_nuevoenvio=$('#btn-modal-nuevoenvio');
var $modal_envio=$('#modal_envio');
var $cbo_cdoventa=$('#cbo_cdoventa');
var $btn_guardar_envio=$('#btn-guardar-envio');

var $txt_origen=$('#txt-origen');
var $txt_destino=$('#txt-destino');
var $txt_hora=$('#txt-hora');


//================================
//==> FNC PAGE PEDIDO
//================================
function init_envio()
{
	listar_envios();
	listar_envios2();
    listar_ventascbo();
	$btn_modal_nuevoenvio.on('click',fnc_modal_envio); 
	$btn_guardar_envio.on('click',fnc_guardar_envio);     
}
//____________________________________________________________________________________________________________________________________________________________________________________________________


//================================
//==>2º MODAL VER NUEVO PEDIDO
//================================
function fnc_modal_envio ()
{
	$modal_envio.modal('show');
	
} 
function fnc_guardar_envio () {	
	
	var data={};
	data.id_venta=$cbo_cdoventa.val();
	data.origen=$txt_origen.val();
	data.destino=$txt_destino.val();
	data.hora=$txt_hora.val();

	$.ajax({
		url: "registrar_envio",
		type:'POST',
		data: JSON.stringify(data),
		contentType: "application/json; charset =utf-8",
		dataType: "json",
		success: function(resp)
		{	
			$modal_envio.modal('hide');	
			listar_envios ();	
		}
	}); 	
}
//____________________________________________________________________________________________________________________________________________________________________________________________________

//================================
//==> FNC LISTAR PRODUCTO AL DATATABLE
//================================
function listar_ventascbo () 
{	
	$.getJSON("listar_ventastotales", function (data) {      
	
		$.each(data, function (i, item) {	

		$cbo_cdoventa.append("<option value='"+item.id_venta+"'>"+item.id_venta+"</option>");	
		$cbo_cdoventa.trigger("chosen:updated");		
		});
	});
}

function listar_envios ()
{
	$.getJSON("listar_envios", function (data){ 

			$table_envio.row().clear().draw( false );			

			$.each(data, function (i, item) {
				
				$table_envio.row.add([item.id_envio,item.id_venta,item.fecha_envio,item.hora_envio,item.destino_envio,item.origen_envio,
				'<a href="javascript:void(0);" data-id="'+item.id_envio+'" class="btn btn-primary btn-xs modal_ver_pedido" ><i class="fa fa-bars" style="font-size:15px;"></i></a>'
				+'&nbsp;<a href="javascript:void(0);" data-id="'+item.id_envio+'" class="btn btn-primary btn-xs" ><i class="fa fa-pencil" style="font-size:15px;"></i></a>'
                +'&nbsp;<a data-id="'+item.id_envio+'" class="btn btn-danger btn-xs"><i class="fa fa-remove" style="font-size:15px;"></i> </a>']).draw(false);				
			});
	});
}
function listar_envios2()
{
	$.getJSON("listar_envios2", function (data){ 

			$table_envio2.row().clear().draw( false );			

			$.each(data, function (i, item) {
				
				$table_envio2.row.add([item.id_envio,item.id_venta,item.fecha_envio,item.hora_envio,item.destino_envio,item.origen_envio,
				'<a href="javascript:void(0);" data-id="'+item.id_envio+'" class="btn btn-primary btn-xs modal_ver_pedido" ><i class="fa fa-bars" style="font-size:15px;"></i></a>'
				+'&nbsp;<a href="javascript:void(0);" data-id="'+item.id_envio+'" class="btn btn-primary btn-xs" ><i class="fa fa-pencil" style="font-size:15px;"></i></a>'
                +'&nbsp;<a data-id="'+item.id_envio+'" class="btn btn-danger btn-xs"><i class="fa fa-remove" style="font-size:15px;"></i> </a>']).draw(false);				
			});
	});
}

//____________________________________________________________________________________________________________________________________________________________________________________________________


$('#from-envio').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
		valid: 'fa fa-check-circle fa-lg text-success',
		invalid: 'fa fa-times-circle fa-lg',
		validating: 'fa fa-refresh'
		},
		fields: {
		origen: {
			message: 'Ingrese un origen.',
			validators: {
				notEmpty: {
			message: 'Ingrese un origen.',
				}
			}
		},
	destino: {
			message: 'Ingrese un destino.',
			validators: {
				notEmpty: {
			message: 'Ingrese un destino.',
				}
			}
		},
		hora: {
			message: 'Ingrese una hora.',
			validators: {
				notEmpty: {
			message: 'Ingrese una hora.',
				}
			}
		},
		}
	}).on('success.field.bv', function(e, data) {
		// $(e.target)  --> The field element
		// data.bv      --> The BootstrapValidator instance
		// data.field   --> The field name
		// data.element --> The field element

		var $parent = data.element.parents('.form-group');

		// Remove the has-success class
		$parent.removeClass('has-success');


		// Hide the success icon
		//$parent.find('.form-control-feedback[data-bv-icon-for="' + data.field + '"]').hide();
	}).on('error.form.bv', function(e) {
		isValid = false;
	});
