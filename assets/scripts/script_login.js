//Inicianilation Page load event
$(document).ready(initPage);

function initPage(){	

	var $btn_login=$('#btn_login');
	$btn_login.on('click',fnc_btn_login);

}

function fnc_btn_login () {
	var username=document.getElementById('username').value;	
	var password=document.getElementById('password').value;	

	var data={};
	data.username=username;
	data.password=password;

	$.ajax({
        type: "POST",
        url: "Principal/login",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        befored: function () { 
        },
        success: function (resp) { 
        	alert(resp);
        }
    });
}