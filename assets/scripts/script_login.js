//Inicianilation Page load event
$(document).ready(initPage);
var $resp=$('#resp');
var $btn_logout=$('#btn-logout');
var $username_text=$('#username_text');

function initPage(){	

	var $btn_login=$('#btn_login');
	$btn_login.on('click',fnc_btn_login);
	// $btn_logout.on('click',fnc_btn_logout);
	$username_text.text(sessionStorage.getItem("nombre_usuario"));
}

function fnc_btn_login () {
	var username=document.getElementById('username').value;	
	var password=document.getElementById('password').value;	

	var data={};
	data.username=username;
	data.password=password;

	$.ajax({
        type: "POST",
        url: "login",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        befored: function () { 
        },
        success: function (resp) { 

			if(resp.nombre_usuario){$resp.empty(); window.location.reload();
			sessionStorage.setItem("nombre_usuario",resp.nombre_usuario)
			}

			else{$resp.html(resp);}
        }
    });
}
