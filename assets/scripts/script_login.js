//Inicianilation Page load event
$(document).ready(initPage);
var $resp=$('#resp');
var $btn_logout=$('#btn-logout');
var $username_text=$('#username_text');

function initPage(){	

	var $btn_login=$('#btn_login');
	$btn_login.on('click',fnc_btn_login);
	// $btn_logout.on('click',fnc_btn_logout);
	$username_text.text(sessionStorage.getItem("nombres_persona"));
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

			if(resp.nombres_persona){$resp.empty(); window.location.reload();
			sessionStorage.setItem("nombres_persona",resp.nombres_persona)
			}

			else{$resp.html(resp);}
        }
    });
}
