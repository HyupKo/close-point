<%@page import="twitter4j.User"%>
<%@page import="Test.TimeLine.HomeTimeline"%>
<%@page import="java.util.Enumeration"%>
<%@page import="twitter4j.Paging"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.SimpleTimeZone"%>
<%@page import="java.util.Calendar"%>
<%@page import="twitter4j.Twitter"%>
<%@page import="twitter4j.http.AccessToken"%>
<%@page import="twitter4j.TwitterFactory"%>
<%@page import="java.util.List"%>
<%@page import="twitter4j.Status"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
 <%
 /*
 	final String CONSUMER_KEY = (String)session.getAttribute("CONSUMER_KEY");
	final String CONSUMER_SECRET = (String)session.getAttribute("CONSUMER_SECRET");
	AccessToken accessToken = (AccessToken)session.getAttribute("accessToken");
	
	//이전 페이지에서 session에 등록한 AccessToken으로 Twitter인스턴스 생성 
	Twitter twitter = new TwitterFactory().getOAuthAuthorizedhome_instance(CONSUMER_KEY, CONSUMER_SECRET, accessToken);
	final String screenName = twitter.getScreenName();
*/

	Twitter twitter = (Twitter)session.getAttribute("_twitter") ;
	User user_info = (User)session.getAttribute("_user");
	String screenName = user_info.getScreenName();

//	final String screenName = twitter.getScreenName();	twitter객체 limit을 줄이기 위해 기본정보를 session에 저장함.

	HomeTimeline home_instance = new HomeTimeline(twitter);
	
	int isNext = 0;
	Enumeration em = request.getParameterNames();
	if( em.hasMoreElements() )	//changed
	{
		String hidden_str;
		String hidden_value;
		
		System.out.println(em);
//		int index=0;
		while( em.hasMoreElements() )
		{
			hidden_str = em.nextElement().toString();
			
			if( hidden_str.equals("hidden_delete") )
			{
				hidden_value = request.getParameter("hidden_delete");
				System.out.println("hidden_delete: "+hidden_value);
				twitter.destroyStatus(Long.parseLong(hidden_value) );
				
			}else if( hidden_str.equals("hidden_retweet") )
			{
				hidden_value = request.getParameter("hidden_retweet");
				System.out.println("hidden_retweet: "+hidden_value);
			//	twitter.retweetStatus( Long.parseLong(hidden_value) );
				long temp = Long.parseLong(hidden_value);
				twitter.retweetStatus( temp );
				
			}else if( hidden_str.equals("hidden_kind") )
			{
				hidden_value = request.getParameter("hidden_kind");
				
	//			if( hidden_value.equals("home"))
	//				home_instance.setPublicNext(true);
				
				int page_num = Integer.parseInt( request.getParameter("hidden_page") );
				int scroll_X = Integer.parseInt( request.getParameter("hidden_scrollX") );
				int scroll_Y = Integer.parseInt( request.getParameter("hidden_scrollY") );
				System.out.println("[testSubmit] hidden_kind: "+hidden_value);
				System.out.println("[testSubmit] hidden_value: "+page_num);
				System.out.println("[testSubmit] scroll_X: "+scroll_X+" scroll_Y: "+scroll_Y);
				home_instance.setPublicPage(hidden_value, page_num);
			//	home_instance.setPublicNext(true);
				home_instance.setPublicScroll(scroll_X, scroll_Y);
				System.out.println("다음페이지임!!");
				isNext = 1;
			}
			/*		parameter hidden_page prior of hidden_kind
			else if( hidden_str.equals("hidden_page") ) //hidden_kind보다 hidden_page가 먼저 나옴?
			{	
				int page_num = Integer.parseInt( request.getParameter("hidden_page") );
				hidden_value = request.getParameter("hidden_kind");
				System.out.println("[testSubmit] hidden_kind: "+hidden_value);
				home_instance.setPublicPage(hidden_value, page_num);
				
			}*/else	
			{
				if( hidden_str.equals("hidden_page") )
					break;
				else
					System.out.println("don't know parameter: "+hidden_str);
			}
			
	//		index++;
	//		System.out.println("index값: "+index);
		}
	}else
		System.out.println("no parameter!");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>TimeLine</title>
	<style>
		@import "css/navigationBar.css";
		@import "css/timeLine.css";
		@import "css/updateStatus.css";
		@import "css/sideBar.css";
	</style>
	<script src="js/DaumMap_v2.js" language="JavaScript"></script>
	<script type="text/javascript" src="js/timeline.js"></script>
	<script type="text/javascript">	 
		window.onload = onLoad;
		
		function onLoad()
		{
			var text = document.getElementById('content_text');
			text.value = "";
			
			var getValue = <%=isNext%>;
			if( getValue != 0)
			{
				var scroll_value = new Array();
				scroll_value[1] = <%=home_instance.home_scroll[1]%>;
				document.body.scrollTop = scroll_value[1];
				document.documentElement.scrollTop =scroll_value[1];
			}
		}
		
	</script>

</head>
<body>
	<jsp:include page="navigationBar.jsp"/>
	<div id="main">
		<div id="main_top">
			<jsp:include page="sideBar.jsp"></jsp:include>
			<jsp:include page="updateStatus.jsp"/>
		</div>
			
		<div id="timeLine">
		<%
		
		List<Status> list = home_instance.HomeTimeLine();
			
		System.out.println("list size: "+list.size());
		
		for( Status status :  list )
		{
			String user = status.getUser().getScreenName();
			
			if( !user.equals(screenName) )
			{
				out.print("<ul>");
				out.print("<img src=\""+status.getUser().getProfileImageURL()+"\"/>");
			/*content_date, content_userID로 출력한 뒤, CSS를 적용할때 float하여 앞에있는 것을 오른쪽으로 띄운다.
				원래는 아래 주석처리한 코드와 같이 content_userID, content_date로 출력한 뒤, 뒤에 있는 <span>을 오른쪽으로 띄웠었는데
				이 방법이 안먹힘.. css를 파일 내에 작성하는 것과 외부의 css를 import하는 방식의 차이가 아닐까 싶음
				out.print("<li class\"info\"><span class=\"content_userID\">"+status.getUser().getScreenName()+"</span>");
				out.print("<span class=\"content_date\">"+status.getCreatedAt()+"</span></li>");*/
				out.print("<li><span class=\"content_date\">"+status.getCreatedAt()+"</span>");
				out.print("<span class=\"content_userID\"><a href=\"http://twitter.com/"+user+"\">"+user+"</a></span></li>");
				out.print("<li>"+status.getText()+"</li>");
				
				out.print("<li><form method=\"post\" id=\"form_"+status.getId()+"\" action=\"#\"><span class=\"content_retweet\">"); 
				out.print("<a href=\"#\" id=\""+status.getId()+"\" onclick=\"onClickRetweet(id)\">retweet</a></span></form>");
				out.print("<span class=\"content_via\">via&nbsp;&nbsp;"+status.getSource()+"</span></li></ul>");
			}else
			{
				out.print("<ul class=\"mine\">");
				out.print("<img src=\""+status.getUser().getProfileImageURL()+"\"/>");
			/*	out.print("<li><span class=\"content_date\">"+status.getCreatedAt()+"</span>");
				out.print("<span class=\"content_userID\">"+status.getUser().getScreenName()+"</span></li>");*/
				out.print("<li><span class=\"content_userID\"><a href=\"http://twitter.com/"+user+"\">"+user+"</a></span>");
				out.print("<span class=\"content_date\">"+status.getCreatedAt()+"</span></li>");
				out.print("<li class=\"content_text\">"+status.getText()+"</li>");
				
				out.print("<form method=\"post\" id=\"form_"+status.getId()+"\" action=\"#\"><span class=\"content_delete\">");
				out.print("<a href=\"#\" id=\""+status.getId()+"\" onclick=\"onClickDelete(id)\">delete</a></span></form></li></ul>");	
			}
		}

	%>		
			<div id="home_footer">
				<%
					int home_page = home_instance.getPublicPage("home")+1;
					out.print("<form method=\"post\" id=\"form_home_next\" action=\"#\"><span id=\"span_next\">");
					out.print("<a  href=\"#\" id=\"home_next\" onclick=\"goNext("+home_page+")\")>NEXT</a></span></form>");
					//현재 출력된 timeline이후의 timeline을 출력하
				%>
			</div>	
		</div>	
	</div>
</body>
</html>