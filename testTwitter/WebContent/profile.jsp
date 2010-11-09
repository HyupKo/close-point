<%@page import="java.util.Enumeration"%>
<%@page import="twitter4j.Status"%>
<%@page import="java.util.List"%>
<%@page import="Test.TimeLine.UserTimeline"%>
<%@page import="twitter4j.User"%>
<%@page import="Test.TimeLine.timeLine"%>
<%@page import="twitter4j.Twitter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Twitter twitter = (Twitter)session.getAttribute("_twitter");
	UserTimeline user_instance = new UserTimeline(twitter);
	User user_info = twitter.showUser( user_instance.getPublicName() );
	
	Enumeration em = request.getParameterNames();
	String hidden_str;
	String hidden_value;
	int isNext = 0;		//첫 페이지일 때 0 
	int index = 1;		//test
	if( em.hasMoreElements() )
	{
		while( em.hasMoreElements() )
		{
			hidden_str = em.nextElement().toString();
			if( hidden_str.equals( "hidden_delete" ) )
			{
				hidden_value = request.getParameter("hidden_delete");
				System.out.println("[profile] "+index+" hidden_delete : "+hidden_value);
				twitter.destroyStatus(Long.parseLong(hidden_value) );
				
			}else if( hidden_str.equals("hidden_kind") )
			{
				hidden_value = request.getParameter("hidden_kind");
			//	System.out.println("[profile] hidden_page: "+request.getParameter("hidden_page"));
			//	System.out.println("[profile] hidden_scrollX: "+request.getParameter("hidden_scrollX"));
			//	System.out.println("[profile] hidden_scrollY: "+request.getParameter("hidden_scrollY"));
				
				if( hidden_value.equals("user") )
				{
					System.out.println("[profile] hidden_kind : user");  //test
					isNext = 1;	//첫 페이지가 아님을 나타낼때 값을 1로 바꿈
					int hidden_page = Integer.parseInt( request.getParameter("hidden_page") );
					int hidden_scrollX = Integer.parseInt( request.getParameter( "hidden_scrollX" ) );
					int hidden_scrollY = Integer.parseInt( request.getParameter("hidden_scrollY") );
					user_instance.setPublicPage(hidden_page);
					user_instance.setPublicScroll( hidden_scrollX, hidden_scrollY );
					System.out.println("hidden_page: "+hidden_page+" hidden_scrollX: "+hidden_scrollX+" hidden_scrollY: "+hidden_scrollY);	//test
					
				}
				
			}else
			{
				System.out.println("else parameter:  "+index+" "+hidden_str);
				break;
			}
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<style type="text/css">
		@import "css/navigationBar.css";
		@import "css/profile.css";
	</style>
	<script type="text/javascript">
		
		window.onload = onLoad;
	
		var now = {};
		var doc_ele = document.documentElement;
		var doc_body = document.body;
		
		var getNowScroll= function(){
										now.X = document.all ? (!doc_ele.scrollLeft ? doc_body.scrollLeft : doc_ele.scrollLeft) : (window.pageXOffset ? window.pageXOffset : window.scrollX);
										now.Y = document.all ? (!doc_ele.scrollTop ? doc_body.scrollTop : doc_ele.scrollTop) : (window.pageYOffset ? window.pageYOffset : window.scrollY);
	
										return now;
									}
		
		function onLoad()
		{		
			var getValue = <%=isNext%>;
			if( getValue != 0)
			{
				var scroll_value = new Array();
				scroll_value[1] = <%=user_instance.user_scroll[1]%>;
				document.body.scrollTop = scroll_value[1];
				document.documentElement.scrollTop =scroll_value[1];
			}
		}
	
		function goNextUser(next_page)
		{
			var scroll = getNowScroll();
			var form_next = document.getElementById("form_user_next");
			form_next.innerHTML += "<input type=\"hidden\" name=\"hidden_kind\" value=\"user\"/>";
			form_next.innerHTML += "<input type=\"hidden\" name=\"hidden_page\" value=\""+next_page+"\"/>";
			form_next.innerHTML += "<input type=\"hidden\" name=\"hidden_scrollX\" value=\""+scroll.X+"\"/>";
			form_next.innerHTML += "<input type=\"hidden\" name=\"hidden_scrollY\" value=\""+scroll.Y+"\"/>";
			form_next.submit();
		}
		
		function deleteStatus(id)
		{
			var name = "form_"+id;
			var form = document.getElementById(name);
			form.innerHTML += "<input type=\"hidden\" name = \"hidden_delete\" value=\""+id+"\"/>";
			form.submit();
		}
		
	
	</script>
</head>
<body>
	<div id="header">
		<jsp:include page="navigationBar.jsp"></jsp:include>
	</div>
	<div id="userTimeline">
		<%
			out.print("<ul class=\"user_info\">");
			out.print("<img src=\""+user_info.getProfileImageURL()+"\">");
			out.print("<li class=\"user_screen\">"+user_info.getScreenName()+"</li>");
			out.print("<li class=\"user_name\">"+user_info.getName()+"</li>");
			out.print("</ul>");
			
			List<Status> user_list = user_instance.getMyTimeLine();
			
			out.print("<div id=\"user_timeline\"");
			
			for( Status status : user_list )
			{
				out.print("<ul class=\"user_list\">");
				out.print("<li class=\"content_date\">"+status.getCreatedAt()+"</span></li>");
				out.print("<li class=\"content_text\">"+status.getText()+"</li>");
				out.print("<li class=\"content_delete\"><form method=\"post\" id=\"form_"+status.getId()+"\" action=\"#\"><a href=\"#\" onclick=\"deleteStatus("+status.getId()+")\">delete</a></li>");
				out.print("</ul>");
			}
			
			out.print("<div id=\"user_footer\">");
			int user_page = user_instance.getPublicPage()+1;
			out.print("<form method=\"post\" id=\"form_user_next\" action=\"#\"><span id=\"span_next\">");
			out.print("<a  href=\"#\" id=\"user_next\" onclick=\"goNextUser("+user_page+")\")>NEXT</a></span></form>");
			//현재 출력된 timeline이후의 timeline을 출력함 
			out.print("</div></div>");
		%>
	</div>
</body>
</html>