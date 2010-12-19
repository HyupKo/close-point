<%@page import="twitter4j.User"%>
<%@page import="twitter4j.Twitter"%>
<%@page import="comm.util.HashMapTwit"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User user_info=null;
	Twitter twitter = (Twitter)session.getAttribute("_twitter");
	HashMapTwit user = (HashMapTwit)session.getAttribute("myUser");
	
	if( session.getAttribute("_user")!=null )
		user_info = (User)session.getAttribute("_user");
%>
	<ul id="subNavigation">
		<%
		//	out.print("<li><span class=\"user_info\">"+user.get("USER_NAME")+"</span><span class=\"label\">이름</span></li>");
		//	out.print("<li><span class=\"user_info\">"+user.get("USER_EMAIL") + "</span><span class=\"label\">&nbsp;</span></li>");
		//	out.print("<li><span class=\"user_info\">"+user.get("USER_TWITTER_ID")+"</span><span class=\"label\">트위터아이디</span></li>");
		//	out.print("<li><div id=\"div_oauth\"><span class=\"oauth\">트위터OAuth</span></div></li>");
		
			out.print("<li><span class=\"user_info\">"+user.get("USER_EMAIL")+"</span></li>");
			out.print("<li><span class=\"user_info\">"+user.get("USER_NAME")+"</span>&nbsp;님</li>");
			
			if( user_info==null)
			{
				out.print("<fieldset><legend>트위터</legend>");
				out.print("<li><span class=\"user_info\">"+user.get("USER_TWITTER_ID")+"</span></li>");
				out.print("<li><div id=\"div_oauth\"><a href=\"../twitterOAuth.jsp\"><span class=\"oauth\">트위터인증하기</span></a></div></li></fieldset>");
			}else
			{
				out.print("<fieldset><legend>트위터</legend>");
				out.print("<img src=\""+user_info.getProfileImageURL()+"\"></img>");
				out.print("<li><span class=\"user_info\">"+user.get("USER_TWITTER_ID")+"</span></li>");
				out.print("<li>limit:&nbsp;"+twitter.getRateLimitStatus().getRemainingHits()+"&nbsp;/&nbsp;350</li></fieldset>");
			}
		%>
	</ul>
