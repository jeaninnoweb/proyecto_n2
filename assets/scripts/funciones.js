//================================
//==> FNC OBTENER DIA ACTUAL
//================================
function get_today(){

  var d = new Date(); var meses=""; var dias=""; var horas=""; var minutos=""; var date = "";
  meses = d.getMonth()+1;  if (meses<10) {  meses = "0"+meses; };
  dias = d.getDate();  if (dias<10) {  dias = "0"+dias;  }; 
  date = d.getFullYear()+"-"+ meses + "-" +dias;
  return date;
}
var $chosen=$('.chosen');
$chosen.chosen({ width: '100%' });