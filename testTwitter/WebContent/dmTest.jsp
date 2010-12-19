<%@page import="twitter4j.Twitter"%>
<%@page import="Test.TimeLine.MessageList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	Twitter twitter = (Twitter)session.getAttribute("_twitter)");
 	MessageList messages = new MessageList( twitter );
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="navigationBar.jsp"></jsp:include>
	<%
	
		java.awt.List friend_list = messages.getFreinds();
			
		out.print("<form method=\"post\" action=\"#\" id=\"send_form\"><span id=\"recipient\">Dear&nbsp;&nbsp;:&nbsp;&nbsp;</span><select id=\"friends_name\">");
		
		for( int index=0; index<friend_list.getItemCount(); index++)
			out.print("<option value=\""+friend_list.getItem(index)+"\">"+friend_list.getItem(index)+"</option>");
		
		out.print("</select>");
		out.print("<span id=\"text_length\">140</span><textarea id=\"dm_text\" name=\"text_value\" onkeyup=\"CountNum()\"></textarea></form>");
		out.print("<div id=\"button_area\"><span id=\"send_button\"><a href=\"#\" onclick=\"sendMessge()\">send</a></span></div>");
	%>
</body>
</html>