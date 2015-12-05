//================================
//==> DOCUMENT READY PAGE_VENTA
//================================
$(document).ready(init_reportes);

//=================================
//==> INICIANILIZACIÓN DE VARIABLES
//=================================



//================================
//==> FNC PAGE PEDIDO
//================================
function init_reportes()
{
	fnc_report_products();
    
}
//____________________________________________________________________________________________________________________________________________________________________________________________________
function fnc_report_products(){
	var array=[];
	var object={};   
	$.getJSON("report_products", function (resp){ 
		for (var i = 0; i < resp.length; i++) {
			object={
                    "category": resp[i].nombre_producto,
                    "column-1": resp[i].cantventas                    
                }
                array.push(object);
		};
		
	});
	bar_productos(array);
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
							"balloonText": "[[title]] of [[category]]:[[value]]",
							"fillAlphas": 1,
							"id": "AmGraph-1",
							"title": "graph 1",
							"type": "column",
							"valueField": "column-1"
						}
					],
					"guides": [],
					"valueAxes": [
						{
							"id": "ValueAxis-1",
							"title": "Axis title"
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
							"text": "Chart Title"
						}
					],
					"dataProvider": array
				}
			);
}