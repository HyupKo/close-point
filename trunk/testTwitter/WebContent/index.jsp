<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		@import "css/main.css";
	</style>
	<script type="text/javascript" src="js/login.js"></script>
</head>
<body>
	<div id="main">
		<span id="login" onclick="clickedLogin()">로그인</span>
		<a href="joinFirst.jsp"><span id="join">서비스에 가입하기</span></a>
	</div>
	
	<form method="post" id="form_login" action="user/loginHome.jsp">
	<ul id="main_login">
		<li><label for="user_id">아이디</label><input type="text" id="user_id" name="USER_EMAIL"/></li>
		<li><label for="user_pass">비밀번호</label><input type="password" id="user_pass" name="USER_PASSWORD"/></li>
		<li id="li_last"><span id="submit" onclick="clickedSubmit()">Login</span><span id="back" onclick="backHome()">Home</span></li>
	</ul></form>	
	<div id="test"></div>
</body>
</html>