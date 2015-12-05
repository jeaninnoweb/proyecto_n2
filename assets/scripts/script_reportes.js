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
	bar_productos();
    
}
//____________________________________________________________________________________________________________________________________________________________________________________________________



function bar_productos () {
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
					"dataProvider": [
						{
							"category": "category 1",
							"column-1": 8
						},
						{
							"category": "category 2",
							"column-1": 6
						},
						{
							"category": "category 3",
							"column-1": 2
						}
					]
				}
			);
}