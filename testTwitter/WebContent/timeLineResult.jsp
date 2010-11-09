<%@page import="twitter4j.TwitterException"%>
<%@page import="java.util.List"%>
<%@page import="twitter4j.Status"%>
<%@page import="Test.TimeLine.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	String screenName = request.getParameter("screenName");
 	String password = request.getParameter("password");

 	GetTimeLine gtl = new GetTimeLine(screenName, password);

  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TimeLine page</title>
<style>
#timeLine 
{
	float: left;
	border: 1px solid lightblue;
	width: 600px;
	padding: 10px 10px;
}

#timeLine ul
{
	/*margin: 0;*/
	width: 580px;
	min-height: 100px;
	max-height: 200px;
	padding-left: 0;
	/*padding-bottom: 10px;*/
	list-style-type: none;
	border-bottom: 1px solid lightblue;
}

#timeLine li
{
	margin: 0 0 10px 80px;
}

#timeLine img
{
	float: left;
	width: 50px;
}
/* 필요없다고 생각됨.
.content_user
{
	border: 1px solid black;
	width: 500px;
}
*/

#timeLine .content_date
{
	float: right;
}

#timeLine .mine li
{
	margin: 0 80px 10px 0;
}

#timeLine .mine img
{
	float: right;
}

#timeLine .mine .content_date
{
	float: none;
}

#timeLine .mine .content_user
{
	float: right;
}

</style>
</head>
<body>
	<div id="timeLine">
	<%
//	try
//	{
		List<Status> list = gtl.getHomeTimeLine();
		
//		Status test1 = list.get(0);
//		String test_name = test1.getUser().getScreenName();
		System.out.println("================");
		System.out.println(list.size());
		System.out.println("================");
	
		for( Status status :  list )
		{
			String user = status.getUser().getScreenName();
			if( !gtl.equalUser( user ) )
			{
				out.print("<ul>");
				out.print("<img src=\""+status.getUser().getProfileImageURL()+"\"/>");
				out.print("<li><span class=\"content_user\">"+status.getUser().getScreenName()+"</span>");
				out.print("<span class=\"content_date\">"+status.getCreatedAt()+"</span></li>");
				out.print("<li>"+status.getText()+"</li>");
				out.print("</ul>");
			}else
			{
				out.print("<ul class=\"mine\">");
				out.print("<img src=\""+status.getUser().getProfileImageURL()+"\"/>");
				out.print("<li><span class=\"content_date\">"+status.getCreatedAt()+"</span>");
				out.print("<span class=\"content_user\">"+status.getUser().getScreenName()+"</span></li>");
				out.print("<li class=\"text\">"+status.getText()+"</li>");
				out.print("</ul>");
			}
		}
//	}catch(TwitterException ex)
//	{
//		out.print("<script>window.alert(\"아이디나 비밀번호 오류\"); history.go(-1);</script>");
//	}
	%>
	</div>
</body>
</html>