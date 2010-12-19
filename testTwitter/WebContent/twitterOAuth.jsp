<%@page import="twitter4j.http.RequestToken"%>
<%@page import="twitter4j.TwitterFactory"%>
<%@page import="twitter4j.Twitter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	final String CONSUMER_KEY = "VUjKXVLvKbeHZZTMbXrsQg";
	final String CONSUMER_SECRET = "qaQ2S7e7b2x5BmbEjUcxSiC6tcOCDD0O938EvDRhPQ";
	
	session.setAttribute("CONSUMER_KEY", CONSUMER_KEY);
	session.setAttribute("CONSUMER_SECRET", CONSUMER_SECRET);
	
	Twitter twitter = new TwitterFactory().getInstance();
	twitter.setOAuthConsumer(CONSUMER_KEY, CONSUMER_SECRET);
	
	RequestToken reqToken = twitter.getOAuthRequestToken();
	session.setAttribute("reqToken", reqToken);	
	
	response.sendRedirect( reqToken.getAuthorizationURL() );
%>