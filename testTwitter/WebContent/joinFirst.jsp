<%@page import="twitter4j.http.RequestToken"%>
<%@page import="twitter4j.TwitterFactory"%>
<%@page import="twitter4j.Twitter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	final String CONSUMER_KEY = "VUjKXVLvKbeHZZTMbXrsQg";
	final String CONSUMER_SECRET = "qaQ2S7e7b2x5BmbEjUcxSiC6tcOCDD0O938EvDRhPQ";
	
	Twitter twitter = new TwitterFactory().getInstance();
	twitter.setOAuthConsumer(CONSUMER_KEY, CONSUMER_SECRET);
	
	RequestToken reqToken = twitter.getOAuthRequestToken();
	String url = reqToken.getAuthorizationURL();
	
	session.setAttribute("reqToken", reqToken);
	session.setAttribute("join", "join");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		@import "css/joinFirst.css";
	</style>
</head>
<body>
	<div>
		<p>가입하시기 전에 트위터인증을 받아야합니다:D</p>
		<span id="button"><a href="<%=url %>">인증하기</a></span>
	</div>
</body>
</html>