<%@page import="twitter4j.DirectMessage"%>
<%@page import="twitter4j.IDs"%>
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
//	UserTimeline user_instance = new UserTimeline(twitter);
//	User user_info = twitter.showUser( user_instance.getPublicName() );
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
/*	Paging page_number = new Paging(1);

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

	IDs ids = twitter.getFollowersIDs("jeongnon");

	int[] arr = ids.getIDs();
	User user;
	
	out.print("Who is following me<br/>");
	for( int i=0; i<arr.length; i++)
	{
		out.print("arr["+i+"]:&nbsp;"+arr[i]+"<br/>");
		user = twitter.showUser(arr[i]);
		out.print(user.getName()+"<br/>");
		out.print(user.getScreenName()+"<br/>");
		out.print("<br/><br/>");

		
	}
	
	out.print("-------------------------------------------------------------------------------<br/><br/>");
	
	out.print("I am following them<br/>");
	
	ids = twitter.getFriendsIDs();
	int[] arr2 = ids.getIDs();
	System.out.println("arr2.length: "+arr2.length);
	for( int i=0; i< arr2.length; i++)
	{
		System.out.println("i:   "+i);
		out.print("arr2["+ i +"]:&nbsp;"+arr2[ i ]+"<br/>");

		user = twitter.showUser( arr2[i] );
		out.print(user.getName()+"<br/>");
		out.print(user.getScreenName()+"<br/>");
		out.print("<br/><br/>");
	}
	
	

		long user_id = ids.getNextCursor();
		User user = twitter.enableNotification( (int)user_id );
		out.print("----------------------------------------<br/>");
		out.print(user.getScreenName()+"<br/>");
		out.print("<br/>");
*/

	Paging p = new Paging();
	

		
		int i = 30;
		while( i <35 )
		{
			p.setPage(i);
			List<Status> list =twitter.getHomeTimeline(p);
			if( !list.isEmpty() )
			{
				out.print("page"+i+"&nbsp;잘됨<br/>");
				out.print("size: "+list.size()+"<br/>");
				out.print(list+"<br/>");
				i++;
			}
			
		}
		
		
	

//	List<DirectMessage> list = twitter.getDirectMessages();
//	out.print( list);
	
%>
</body>
</html>