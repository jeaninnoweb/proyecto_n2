//================================
//==> DOCUMENT READY PAGE_VENTA
//================================
$(document).ready(init_usuario);

//=================================
//==> INICIANILIZACIÓN DE VARIABLES
//=================================


var $btn_modal_adduser=$('#btn-modal-adduser');
var $modal_usuario=$('#modal_usuario');
var $table_usuario=$('#data-table-usuario').DataTable({"responsive": true, "language": {"paginate": {"previous": '<i class="fa fa-angle-left"></i>', "next": '<i class="fa fa-angle-right"></i>'} }, "dom": '<"newtoolbar">frtip'});

var $cbo_permisos=$('#cbo_permisos');


//================================
//==> FNC PAGE PEDIDO
//================================
function init_usuario()
{
	listar_usuario();

	/*2º*/$btn_modal_adduser.on('click',fnc_modal_adduser);
	/*2º*/$cbo_permisos.on('change',fnc_change_permisos);
	// /*3º*/$btn_guardar_venta.on('click',fnc_guardar_venta);
	// listar_ventastotales ();
   // $(document).on('click','.modal_ver_venta',fnc_modal_verventa);    
    
}
//____________________________________________________________________________________________________________________________________________________________________________________________________


//================================
//==>2º MODAL VER NUEVO PEDIDO
//================================
function fnc_modal_adduser ()
{
	$modal_usuario.modal('show');	
	listar_permisos();
} 

//================================
//==>3º CLICK GUARDAR PEDIDO
//================================


function fnc_change_permisos () {
	var _idpermisos=$cbo_permisos.val();
	if(_idpermisos==1 || _idpermisos==4)
	{
		$('.rcliente').hide();
		$('#rpersona').show();
		
	}
	else if(_idpermisos==2)
	{
		$('#rclienten').show();
		$('#rclientej').hide();
		$('#rpersona').show();
	}
	else if(_idpermisos==3)
	{		
		$('#rclientej').show();
		$('#rpersona').hide();
	}

}


function listar_usuario () 
{	
	$.getJSON("listar_usuario", function (data) {      
		$table_usuario.row().clear().draw( false );
		
		$.each(data, function (i, item) {			
			$table_usuario.row.add([item.id_usuario,item.alias_usuario,item.password_usuario,item.nombres_persona,item.nombre_permisos,
			'<a href="javascript:void(0);" data-id="'+item.id_usuario+'" class="btn btn-primary btn-xs" ><i class="fa fa-pencil" style="font-size:15px;"></i></a>'
            +'&nbsp;<a data-id="'+item.id_usuario+'" class="btn btn-danger btn-xs"><i class="fa fa-remove" style="font-size:15px;"></i> </a>']).draw(false);				
		});
	});
}

function listar_permisos () 
{	
	$.getJSON("listar_permisos", function (data) {  
		$cbo_permisos.html('<option value="" disabled selected style="display:none;">--Seleccione--</option>');
		$.each(data, function (i, item) {
		$cbo_permisos.append("<option value='"+item.id_permisos+"'>"+item.nombre_permisos+"</option>");	
		$cbo_permisos.trigger("chosen:updated");				
		});
	});
}


