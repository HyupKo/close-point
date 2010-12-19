<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		@import "css/sideBar.css";
		@import "css/navigationBar.css";
		@import "css/loginHome.css";
	</style>
</head>
<body>
	<jsp:include page="navigationBar.jsp"></jsp:include>
	<div id="main">
		<jsp:include page="sideBar.jsp"></jsp:include>
		<div id="articles">
			<%
				out.print("나중에 결과 출력할거임!");			
			%>
		</div>
	</div>
</body>
</html>