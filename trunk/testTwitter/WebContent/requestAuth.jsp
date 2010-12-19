<%@page import="twitter4j.conf.ConfigurationBuilder"%>
<%@page import="twitter4j.TwitterException"%>
<%@page import="twitter4j.http.RequestToken"%>
<%@page import="twitter4j.TwitterFactory"%>
<%@page import="twitter4j.http.OAuthAuthorization"%>
<%@page import="twitter4j.http.AccessToken"%>
<%@page import="twitter4j.Twitter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	final String CONSUMER_KEY = (String)session.getAttribute("CONSUMER_KEY");
	final String CONSUMER_SECRET = (String)session.getAttribute("CONSUMER_SECRET");
	
	String oauth_token = request.getParameter("oauth_token");
	
	Twitter twitter = new TwitterFactory().getOAuthAuthorizedInstance(CONSUMER_KEY, CONSUMER_SECRET);
	RequestToken reqToken = (RequestToken)session.getAttribute("reqToken");
	
//	RequestToken reqToken = twitter.getOAuthRequestToken();	//이거로하면 안됨! 이유를 모르겠으나,, 내부적으로 뭔가해주나봄

	//이걸 안하면 ID랑 password or consmer_key, consumer_secret을 넣으라함,, 그래놓고 twitter에 집어넣는다던지 그런거 안함 이게 알아서 해주는거임?
	AccessToken acsToken = twitter.getOAuthAccessToken(reqToken);
	/*getOAuthAccessToken() :   Retrieves an access token associated with the supplied request token and sets userId.
											제공된? request token과 관련된 access token을 되찾아와?검색한다?암튼 가져오고 userid를 set해준다는걸
											보면 request token으로 access token을 생성할 때 해주나봄*/
		
	session.setAttribute("_twitter", twitter);		//twitter인스턴스를 세션에 등록해서 계속 사용할 것임
	session.setAttribute("_user", twitter.showUser(twitter.getScreenName()) );
	
	if( session.getAttribute("join") != null )
	{
		session.removeAttribute("join");
		response.sendRedirect("join.jsp");
	}
	else
		response.sendRedirect("timeLine.jsp");
%>

