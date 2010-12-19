<%@page import="twitter4j.User"%>
<%@page import="twitter4j.DirectMessage"%>
<%@page import="java.util.List"%>
<%@page import="twitter4j.Twitter"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//	Twitter twitter = (Twitter)session.getAttribute("_twitter");
	


	/*
	List<DirectMessage> list =  twitter.getDirectMessages();
	List<DirectMessage> sentlist = twitter.getSentDirectMessages();
	
	System.out.println("list size:  "+list.size());
	System.out.println("sentlist size:  "+sentlist.size());
	
	if( list.isEmpty() )
		System.out.println("get list is empty!!");
	else
		System.out.println("get list is not empty!!");
	
	if( sentlist.isEmpty() )
		System.out.println("sent list is empty!!");
	else
	{
		System.out.println("sent list is not empty!!");
		out.print( sentlist.get(0));
	}
	*/

	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		@import "css/navigationBar.css";
	</style>
</head>
<body>
	<jsp:include page="navigationBar.jsp"></jsp:include>
	<div id="content">
		
	</div>
</body>
</html>