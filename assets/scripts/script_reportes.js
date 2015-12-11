//================================
//==> DOCUMENT READY PAGE_VENTA
//================================
$(document).ready(init_reportes);

//=================================
//==> INICIANILIZACIÓN DE VARIABLES
//=================================
var $btn_aceptar=$('#btn-aceptar');
var $btn_aceptar2=$('#btn-aceptar2');


//================================
//==> FNC PAGE PEDIDO
//================================
function init_reportes()
{
	$btn_aceptar.on('click',fnc_report_products);    
	$btn_aceptar2.on('click',fnc_report_clientes);    
}
//____________________________________________________________________________________________________________________________________________________________________________________________________
function fnc_report_products(){
	var array=[];
	var object={}; 
	var data={};
	data.anio=$('#cbo_año').val();
	data.mes=$('#cbo_mes').val();
	$.ajax({
		url: "report_products",
		type:'POST',
		data: JSON.stringify(data),
		contentType: "application/json; charset =utf-8",
		dataType: "json",
		success: function(resp)
		{
			for (var i = 0; i < resp.length; i++) {
			object={
                    "category": resp[i].nombre_producto,
                    "column-1": resp[i].cantventas                    
                }
                array.push(object);
		};
		bar_productos(array);
		}
	});	
}


function bar_productos (array) {
	AmCharts.makeChart("chartdiv",
				{
					"type": "serial",
					"categoryField": "category",
					"angle": 11,
					"depth3D": 24,
					"marginRight": 18,
					"colors": [
						"#579DDB"
					],
					"startDuration": 1,
					"categoryAxis": {},
					"gridPosition": "start",
					"trendLines": [],
					"graphs": [
						{
							"balloonText": "[[category]]:[[value]]",
							"fillAlphas": 1,
							"id": "AmGraph-1",
							"title": "Productos",
							"type": "column",
							"valueField": "column-1",
							"labelText": "[[value]]"
						}
					],
					"guides": [],
					"valueAxes": [
						{
							"id": "ValueAxis-1",
							"stackType": "regular"      
						}
					],
					"allLabels": [],
					"balloon": {},
					"export": {
						"enabled": true
					},
					"legend": {
						"enabled": true,
						"useGraphSettings": true
					},
					"titles": [
						{
							"id": "Title-1",
							"size": 15,
							"text": "REPORTE DE VENTAS DE PRODUCTOS : "+$('#cbo_mes option:selected').text()+' - '+$('#cbo_año').val()
						}
					],
					"dataProvider": array
				}
			);
}

function fnc_report_clientes(){
	var array=[];
	var object={}; 
	var data={};
	data.anio=$('#cbo_año').val();
	data.mes=$('#cbo_mes').val();
	$.ajax({
		url: "report_clientes",
		type:'POST',
		data: JSON.stringify(data),
		contentType: "application/json; charset =utf-8",
		dataType: "json",
		success: function(resp)
		{
			for (var i = 0; i < resp.length; i++) {
			object={
                    "category": resp[i].nombres_persona,
                    "column-1": resp[i].cantventas                    
                }
                array.push(object);
		};
		bar_clientes(array);
		}
	});	
}


function bar_clientes (array) {
	AmCharts.makeChart("chartdiv2",
				{
					"type": "serial",
					"categoryField": "category",
					"angle": 11,
					"depth3D": 24,
					"marginRight": 18,
					"colors": [
						"#579DDB"
					],
					"startDuration": 1,
					"categoryAxis": {},
					"gridPosition": "start",
					"trendLines": [],
					"graphs": [
						{
							"balloonText": "[[category]]:[[value]]",
							"fillAlphas": 1,
							"id": "AmGraph-1",
							"color":"#000",
							"title": "Clientes",
							"type": "column",
							"valueField": "column-1",
							"labelText": "[[value]]"
						}
					],
					"guides": [],
					"valueAxes": [
						{
							"id": "ValueAxis-1",
							"stackType": "regular"      
						}
					],
					"allLabels": [],
					"balloon": {},
					"export": {
						"enabled": true
					},
					"legend": {
						"enabled": true,
						"useGraphSettings": true
					},
					"titles": [
						{
							"id": "Title-1",
							"size": 15,
							"text": "REPORTE DE VENTAS POR CLIENTES : "+$('#cbo_mes option:selected').text()+' - '+$('#cbo_año').val()
						}
					],
					"dataProvider": array
				}
			);
}