<%@page import="twitter4j.User"%>
<%@page import="java.util.List"%>
<%@page import="Test.TimeLine.followerList"%>
<%@page import="twitter4j.Twitter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Twitter twitter = (Twitter)session.getAttribute("_twitter");
	followerList list_inst = new followerList(twitter);
	int friends_page;
	int followers_page;
	String isFirst = null;
	
	if( request.getParameter("page")!=null )
	{
		String str = request.getParameter("page").toString();
		if( str.equals("friends") )
		{
			isFirst = "friends";
			System.out.println("friends form");
			friends_page = Integer.parseInt( request.getParameter("friends_page").toString() );
			System.out.println("Page  = "+friends_page);
			followers_page = 1;
		}else
		{
			isFirst = "followers";
			System.out.println("followers form");
			followers_page = Integer.parseInt( request.getParameter("followers_page").toString() );
			friends_page = 1;
		}
	}else
	{
		System.out.println("no parameter");
		friends_page = 1;
		followers_page = 1;
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		@import "css/navigationBar.css";
		@import "css/followerList.css";
		@import "css/sideBar.css";
	</style>
	<script type="text/javascript" src="js/followerList.js"></script>
	<script type="text/javascript">
	window.onload = showPage;
	
	function showPage()
	{
		document.getElementById("test").innerHTML = "onload한다!";
		var type = "<%=isFirst%>";
		if(type!=null)
		{
			if(type=="friends")
			{
				showFriends();
			}
			else if(type=="followers")
				showFollowers();
		}
	}

	</script>
</head>
<body>
	<jsp:include page="navigationBar.jsp"></jsp:include>
	<div id="main">
		<jsp:include page="sideBar.jsp"></jsp:include>
		<div id="followerList">
			<% 
				List<User> friends = list_inst.getPublicList("friends");
				List<User> followers = list_inst.getPublicList("followers");
				int friends_last = friends.size()/10+1, followers_last = followers.size()/10+1;
				out.print("<div id=\"choice\"><span class=\"follow\" onclick=\"showFriends()\">"+friends.size()+"&nbsp;friends</span>");
				out.print("<span class=\"follow\" onclick=\"showFollowers()\">"+followers.size()+"&nbsp;followers</span></div>");
				
				out.print("<div id=\"friends\">");		//친구목록을 출력
				out.print("<span class=\"text\">Your Friends:D</span>");
				User user;
				int last_index = friends_page*10;
				if( last_index>friends.size() )
					last_index = friends.size();
				for( int index=(friends_page-1)*10; index<last_index; index++)
				{
					try{
					user= friends.get(index);
					out.println("<ul id=\""+user.getScreenName()+"\">");
				//	out.print("<img src=\""+twitter.showUser(name).getProfileImageURL()+"\"/>");
					out.print("<img src=\""+user.getProfileImageURL()+"\"/>");
					out.print("<li><span class=\"screenName\"><a href=\"http://twitter.com/"+user.getScreenName()+"\">"+user.getScreenName()+"</a></span>");
					out.print("<span class=\"userName\">"+user.getName()+"</span></li>");
					if(user.getStatus() != null)
						out.print("<li><span class=\"userText\">"+user.getStatus().getText()+"</span></li>");
					else 
						out.print("<li><span class=\"userText\">&nbsp;</span></li>");
					out.println("</ul>");
					}catch(NullPointerException e)
					{
						System.out.println("NullException index: "+index);
					}
				}
			
				out.print("<div id=\"friends_footer\">");
				if( friends_page==1 )
					out.print("<span class=\"dis_button\">pre</span>");
				else															
					out.print("<span class=\"page_button\" onclick=\"clickedPage('friends','"+friends_page+"', -1)\">pre</span>");
				out.print("<span id=\"page\">"+friends_page+"</span>");
				if( friends_page==friends_last )
					out.print("<span class=\"dis_button\">next</span>");
				else
					out.print("<span class=\"page_button\" onclick=\"clickedPage('friends','"+friends_page+"', 1)\">next</span>");
				out.print("<form id=\"friend_form\" method=\"post\" action=\"#\">");
				out.print("<input type=\"hidden\" name=\"page\" value=\"friends\"/>");
				
				out.print("</form></div></div>");		
				
				out.print("<div id=\"followers\">");	//follower목록을 출력
				out.print("<span class=\"text\">Your Followers:D</span>");
				last_index = followers_page*10;
				if( last_index>followers.size() )
					last_index = followers.size();
				for( int index=(followers_page-1)*10; index<last_index; index++)
				{
					try{
					user = followers.get(index);
					out.println("<ul id=\""+user.getScreenName()+"\">");
					out.print("<img src=\""+user.getProfileImageURL()+"\"/>");
					
					if( friends.contains(user) )
						out.print("<li><span class=\"isFollow\">following</span>");
					else
						out.print("<li><span class=\"isFollow\">unfollowing</span>");
					out.print("<span class=\"screenName\"><a href=\"http://twitter.com/"+user.getScreenName()+"\">"+user.getScreenName()+"</a></span>");
					out.print("<span class=\"userName\">"+user.getName()+"</span></li>");
					if( user.getStatus()!=null)
						out.print("<li><span class=\"userText\">"+user.getStatus().getText()+"</span></li>");
					else
						out.print("<li><span class=\"userText\"></span></li>");
					out.println("</ul>");
					}catch(NullPointerException e)
					{
						System.out.println("NullException index: "+index);
					}
				}
				
				out.print("<div id=\"followers_footer\">");
				if( followers_page==1 )
					out.print("<span class=\"dis_button\">pre</span>");
				else
					out.print("<span class=\"page_button\" onclick=\"clickedPage('followers','"+followers_page+"', -1)\">pre</span>");
				out.print("<span id=\"page\">"+followers_page+"</span>");
				if( followers_page==followers_last )
					out.print("<span class=\"dis_button\">next</span>");
				else
					out.print("<span class=\"page_button\" onclick=\"clickedPage('followers','"+followers_page+"', 1)\">next</span>");
				out.print("<form id=\"follower_form\" method=\"post\" action=\"#\">");
				out.print("<input type=\"hidden\" name=\"page\" value=\"followers\"/>");

				out.print("</form></div></div>");
			%>
			
		</div>
	</div>
	<div id="test"></div>
</body>
</html>