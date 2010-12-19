<%@page import="testTwitter.article.ArticleProc"%>
<%@page import="comm.util.HashMapTwit"%>
<%@page import="java.util.HashMap"%>
<%@page import="testTwitter.user.UserProc"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	HashMapTwit user, articles;

	if( session.getAttribute("myUser")!=null )
	{
		user = (HashMapTwit)session.getAttribute("myUser");
	}else
	{
		UserProc users = new UserProc();
		String mailAdd = request.getParameter("USER_EMAIL");
		String password = request.getParameter("USER_PASSWORD");
		user = users.confirmLogin(mailAdd, password);
		session.setAttribute("myUser", user);
	}
	
//	ArticleProc article = new ArticleProc();
//	articles = article.getArticles( user.get("USER_ID").toString() );
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		@import "../css/sideBar.css";
		@import "../css/navigationBar.css";
		@import "../css/loginHome.css";
	</style>
</head>
<body>
	<jsp:include page="../navigationBar.jsp"></jsp:include>
	<div id="main">
		<jsp:include page="../sideBar.jsp"></jsp:include>
		<div id="articles">
			<%
				out.print("나중에 결과 출력할거임!");			
			%>
		</div>
	</div>
</body>
</html>