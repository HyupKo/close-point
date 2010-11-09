<%@page import="twitter4j.conf.ConfigurationBuilder"%>
<%@page import="twitter4j.conf.Configuration"%>
<%@page import="twitter4j.http.Authorization"%>
<%@page import="twitter4j.http.AccessToken"%>
<%@page import="twitter4j.http.RequestToken"%>
<%@page import="twitter4j.TwitterFactory"%>
<%@page import="twitter4j.Twitter"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	final String CONSUMER_KEY = "VUjKXVLvKbeHZZTMbXrsQg";
	final String CONSUMER_SECRET = "qaQ2S7e7b2x5BmbEjUcxSiC6tcOCDD0O938EvDRhPQ";
	
	session.setAttribute("CONSUMER_KEY", CONSUMER_KEY);
	session.setAttribute("CONSUMER_SECRET", CONSUMER_SECRET);
	
	Twitter twitter = new TwitterFactory().getInstance();
	twitter.setOAuthConsumer(CONSUMER_KEY, CONSUMER_SECRET);
	
	RequestToken reqToken = twitter.getOAuthRequestToken();

	String tokenSecret = reqToken.getTokenSecret();
	String token = reqToken.getToken();
	
	session.setAttribute("token", token);
	session.setAttribute("tokenSecret", tokenSecret);
	session.setAttribute("session_twit", twitter);
	
	//out.print(session.getAttribute("token"));
	//out.print(session.getAttribute("tokensecret"));

	
	out.write("<a href=" + reqToken.getAuthorizationURL() + "> 트윗 인증하기 </a>");

	
	
	
%>