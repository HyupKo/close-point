<%@page import="twitter4j.Paging"%>
<%@page import="twitter4j.Status"%>
<%@page import="java.util.List"%>
<%@page import="twitter4j.User"%>
<%@page import="Test.TimeLine.UserTimeline"%>
<%@page import="twitter4j.Twitter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Twitter twitter = (Twitter)session.getAttribute("_twitter");
	UserTimeline user_instance = new UserTimeline(twitter);
	User user_info = twitter.showUser( user_instance.getPublicName() );
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		#test
		{
			display: none;
		}
		
		.ul_list
		{
			list-style-type: none;
			border: 1px solid lightblue;
			/*display: none;*/
		}
		
		
		
	</style>
	
	<script type="text/javascript">
	
		function clicked()
		{
			var div = document.getElementById("test");
			div.style.display="block";
		//	div.style.display="none";
		}
		
		function clickedSender()
		{
			var content = document.getElementById("test");
			content.style.display="block";
		}
	
	</script>
</head>
<body>
<%
	Paging page_number = new Paging(1);

	List<Status> user_list = twitter.getUserTimeline( page_number );
	out.print("<div id=\"test\">");
	for( Status status : user_list )
	{
		out.print("<ul class=\"ul_list\">");
		out.print("<li>"+status.getId()+"</li>");
		out.print("<li>"+status.getText()+"</li>");
		out.print("</ul>");
	}
	out.print("</div>");
	
	out.print("<input type=\"button\" value=\"id출력\" onclick=\"clickedSender()\"/>");

%>
</body>
</html>