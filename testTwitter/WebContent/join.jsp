<%@page import="twitter4j.TwitterException"%>
<%@page import="twitter4j.http.RequestToken"%>
<%@page import="twitter4j.TwitterFactory"%>
<%@page import="twitter4j.Twitter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Twitter twitter = (Twitter)session.getAttribute("_twitter");
	String user_name = twitter.getScreenName();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		@import "css/join.css";
	</style>
	<script type="text/javascript">
		function join_button()
		{
			document.getElementById("join_form").submit();
		}
	</script>
</head>
<body>
	<form method="post" id="join_form" action="./user/regist_user.jsp">
		<ul>
<!--  			<li><span class="space">NAME</span><input type="text" id="name"></li>		-->
				<%
					out.print("<li><label for=\"twit_id\">SCREEN&nbsp;NAME</label>");
					out.print("<input type=\"text\" id=\"twit_id\" value=\""+user_name+"\" name=\"USER_TWITTER_ID\" ></li>");
				%>
			<li><label for="mailAdd">E-MAIL ADDRESS</label><input type="text" id="mailAdd" name="USER_EMAIL"></li>
			<li><label for="name">NAME</label><input type="text" id="name" name="USER_NAME"></li>
			<li><label for="password">PASSWORD</label><input type="password" id="password" name="USER_PASSWORD"></li>
		</ul>
		<div id="join" align="center">
			<span id="join_button" onclick="join_button();">JOIN</span>
		</div>
	</form>
	
</body>
</html>