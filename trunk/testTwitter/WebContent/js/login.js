window.onload = windowOnLoad;
		
function windowOnLoad()	//파이어폭스에서 새로고침할 때 값이 지워지지 않는다.
{
	document.getElementById("user_id").value ="";
}
	
function clickedLogin()
{
	document.getElementById("main").style.display="none";
	document.getElementById("main_login").style.display="block";					
}

function clickedSubmit()
{
	document.getElementById("form_login").submit();
}

function backHome()
{
	document.getElementById("main").style.display="block";
	document.getElementById("main_login").style.display="none";
	document.getElementById("user_id").value = "";
	document.getElementById("user_pass").value = "";
}