<%@page import="twitter4j.http.OAuthAuthorization"%>
<%@page import="twitter4j.http.AccessToken"%>
<%@page import="twitter4j.Twitter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	final String CONSUMER_KEY = (String)session.getAttribute("CONSUMER_KEY");
	final String CONSUMER_SECRET = (String)session.getAttribute("CONSUMER_SECRET");
	
	String oauth_token = request.getParameter("oauth_token");
	String tokenSecret = (String)session.getAttribute("tokenSecret");
		
	Twitter twitter = new Twitter();
	twitter.setOAuthConsumer(CONSUMER_KEY, CONSUMER_SECRET);
	
	AccessToken accessToken = twitter.getOAuthAccessToken(oauth_token, tokenSecret);
	session.setAttribute("accessToken", accessToken); 			//TWITTER인스턴스 생성시에 필요함.
	session.setAttribute("_twitter", twitter);
	
	response.sendRedirect("timeLine.jsp");
%>

