//================================
//==> DOCUMENT READY PAGE_VENTA
//================================
$(document).ready(init_pageventa);

//=================================
//==> INICIANILIZACIÓN DE VARIABLES
//=================================

var $btn_guardar_venta=$('#btn_guardar_venta');
var $btn_modal_nuevaventa=$('#btn-modal-nuevaventa');
var $modal_venta=$('#modal_venta');
var $modal_verventa=$('#modal_verventa');
var $table_saletotal=$('#data-table-salestotal').DataTable({"responsive": true, "language": {"paginate": {"previous": '<i class="fa fa-angle-left"></i>', "next": '<i class="fa fa-angle-right"></i>'} }, "dom": '<"newtoolbar">frtip'});

var $cbo_compropago=$('#cbo_compropago');
var $txt_cliente=$('#txt_cliente');
var $cbo_tdoc=$('#cbo_tdoc');
var $txt_nrodoc=$('#txt_nrodoc');

//================================
//==> FNC PAGE PEDIDO
//================================
function init_pageventa()
{
	/*2º*/$btn_modal_nuevaventa.on('click',fnc_modal_nuevaventa);
	/*3º*/$btn_guardar_venta.on('click',fnc_guardar_venta);
	listar_ventastotales ();
   $(document).on('click','.modal_ver_venta',fnc_modal_verventa);    
    
}
//____________________________________________________________________________________________________________________________________________________________________________________________________


//================================
//==>2º MODAL VER NUEVO PEDIDO
//================================
function fnc_modal_nuevaventa ()
{
	$modal_venta.modal('show');
	listar_produtos();
	$('.rventa').val('');
	$('#demo-bv-wz a[href="#demo-bv-tab1"]').tab('show');	
} 

//================================
//==>3º CLICK GUARDAR PEDIDO
//================================
function fnc_guardar_venta()
{
	var all_products=[];
	var cant_products=[];
	var select_product=$('.select-product').length;
	var $cant_product=$('.cant_product');
	var productid;
	var productcant;
	var data={};
	var data2={}; 

	for (var i = 0; i < select_product; i++)
	{
		if($('.select-product').eq(i).is(':checked'))
		{
			productid=$('.select-product').eq(i).val();			
		    all_products.push(productid);
			productcant=$cant_product.eq(i).val();
			cant_products.push(productcant);
		}
	}

	data.fecha_venta=get_today();	
	data.total_venta=0;
	data.tipo_compropago=$cbo_compropago.val();
	data.nom_compropago=$txt_cliente.val();
	data.tipo_docidentidad=$cbo_tdoc.val();
	data.nro_docidentidad=$txt_nrodoc.val();
if(data.tipo_compropago==null || data.nom_compropago=='' || data.tipo_docidentidad==null || data.nro_docidentidad==''){return;}
	$.ajax({
		url: "registrar_ventam",
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
					$modal_venta.modal('hide');
					listar_ventastotales ();
				}
			}); 
		}
	}); 		
}

function fnc_modal_verventa () 
{
	var id_venta=$(this).attr('data-id');
	var tcompro_pago,tdociden,nom_comp;
	var total_venta=0;
	var data={};

	$table_sale2.row().clear().draw( false );
	$modal_verventa.modal('show');
	data.id_venta=id_venta;

	$.ajax({
		url: "consultar_venta",
		type:'POST',
		data: JSON.stringify(data),
		contentType: "application/json; charset =utf-8",
		dataType: "json",
		success: function(resp)
		{			
			if(resp[0].tipo_compropago==1){tcompro_pago='FACTURA'}
			else{tcompro_pago='BOLETA'}	

			if(resp[0].tipo_docidentidad==1){tdociden='RUC';nom_comp='RAZÓN SOCIAL';}
			else{tdociden='DNI';nom_comp='NOMBRES';}	

			$tcompropago.html('<div class="row" ><div class="col-md-12 div-tcompropago"><div class="col-md-12"><b>'+tcompro_pago+'</b></div><div class="col-md-12"> Nº '+resp[0].id_venta+'</div></div>'
		    +'</div>');

			$infocomp.html('<div class="row" ><div class="col-md-12"><b>'+nom_comp+' :</b>&nbsp;&nbsp;'+resp[0].nom_compropago+'</div></div>'
			+'<div class="row" ><br/><div class="col-md-12"><b>'+tdociden+': </b>&nbsp;&nbsp;Nº '+resp[0].nro_docidentidad+'</div></div>');
			
			for (var i=0;i<resp.length;i++ )
			{
				$table_sale2.row.add([resp[i].id_producto,resp[i].nombre_producto,resp[i].descripcion_producto,
				resp[i].cantidad_dtventa,'S/. '+resp[i].precio_producto,'S/. '+resp[i].total_dtventa
				]).draw(false);	
				total_venta=total_venta+parseFloat(resp[i].total_dtventa);
			};

			$('#total').html('TOTAL: S/. '+parseFloat(total_venta).toFixed(2));
		}
	});
}


function listar_ventastotales () 
{	
	$.getJSON("listar_ventastotales", function (data) {      
		$table_saletotal.row().clear().draw( false );
		var tcompro_pago,tdociden;
		$.each(data, function (i, item) {	

			if(item.tipo_compropago==1){tcompro_pago='FACTURA'}
			else{tcompro_pago='BOLETA'}	

			if(item.tipo_docidentidad==1){tdociden='RUC';}
			else{tdociden='DNI';}	

			$table_saletotal.row.add([item.id_venta,tcompro_pago,item.fecha_venta,item.nom_compropago,tdociden,item.nro_docidentidad,item.nro_productos,'S/. '+item.total_venta,item.nombres_persona,
			'<a href="javascript:void(0);" data-id="'+item.id_venta+'" class="btn btn-primary btn-xs modal_ver_venta" ><i class="fa fa-bars" style="font-size:15px;"></i></a>'
			+'&nbsp;<a href="javascript:void(0);" data-id="'+item.id_venta+'" class="btn btn-primary btn-xs" ><i class="fa fa-pencil" style="font-size:15px;"></i></a>'
            +'&nbsp;<a data-id="'+item.id_venta+'" class="btn btn-danger btn-xs"><i class="fa fa-remove" style="font-size:15px;"></i> </a>']).draw(false);				
		});
	});
}

$('#demo-bv-wz-form').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
		valid: 'fa fa-check-circle fa-lg text-success',
		invalid: 'fa fa-times-circle fa-lg',
		validating: 'fa fa-refresh'
		},
		fields: {
		compropago: {
			message: 'Seleccione un tipo de comprobante de pago.',
			validators: {
				notEmpty: {
					message: 'Seleccione un tipo de comprobante de pago.',
				}
			}
		},cbo_tdoc: {
			message: 'Seleccione un tipo de documento de identidad.',
			validators: {
				notEmpty: {
					message: 'Seleccione un tipo de documento de identidad.',
				}
			}
		},
		txt_cliente: {
			message: 'Ingrese un cliente.',
			validators: {
				notEmpty: {
					message: 'Ingrese un cliente.'
				}
			}
		},
		txt_nrodoc: {
			message: 'Ingrese Nro de documento.',
			validators: {
				notEmpty: {
					message: 'Ingrese Nro de documento.',
				}
			}
		},
		firstName: {
			validators: {
				notEmpty: {
					message: 'The first name is required and cannot be empty'
				},
				regexp: {
					regexp: /^[A-Z\s]+$/i,
					message: 'The first name can only consist of alphabetical characters and spaces'
				}
			}
		},
		lastName: {
			validators: {
				notEmpty: {
					message: 'The last name is required and cannot be empty'
				},
				regexp: {
					regexp: /^[A-Z\s]+$/i,
					message: 'The last name can only consist of alphabetical characters and spaces'
				}
			}
		},
		phoneNumber: {
			validators: {
				notEmpty: {
					message: 'The phone number is required and cannot be empty'
				},
				digits: {
					message: 'The value can contain only digits'
				}
			}
		},
		address: {
			validators: {
				notEmpty: {
					message: 'The address is required'
				}
			}
		}
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
