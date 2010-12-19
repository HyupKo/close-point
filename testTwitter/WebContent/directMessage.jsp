<%@page import="java.awt.List"%>
<%@page import="twitter4j.User"%>
<%@page import="java.util.Enumeration"%>
<%@page import="Test.TimeLine.EachMessageInfo"%>
<%@page import="Test.TimeLine.MessageList"%>
<%@page import="twitter4j.DirectMessage"%>
<%@page import="twitter4j.Twitter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Twitter twitter = (Twitter)session.getAttribute("_twitter");

	Enumeration em = request.getParameterNames();
	while( em.hasMoreElements() )
	{
		String str = em.nextElement().toString();
		if( str.equals("text_value") )
		{
			String text = request.getParameter(str);
			String recipient = request.getParameter("recipient");
			twitter.sendDirectMessage(recipient, text);
		}else if( str.equals("hidden_num") )
		{
			int message_num = Integer.parseInt( request.getParameter(str) );
			twitter.destroyDirectMessage( message_num );
		}else
			System.out.println("unknown: ");
	}


	MessageList messages = new MessageList(twitter);		//dm결과를 sender마다 분
	
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		@import "css/navigationBar.css";
		@import "css/sendMessage.css";
		@import "css/directMessage.css";
		@import "css/sideBar.css";
	</style>
	<script type="text/javascript" src="js/directMessage.js"></script>
</head>
<body>
	<jsp:include page="navigationBar.jsp"></jsp:include>
	<div id="main">
		<jsp:include page="sideBar.jsp"></jsp:include>
		<div id="writing">
		<%
			List friend_list = messages.getFreinds();
		
			out.print("<form method=\"post\" action=\"#\" id=\"send_form\"><span id=\"recipient\">Dear&nbsp;&nbsp;:&nbsp;&nbsp;</span><select id=\"friends_name\" name=\"recipient\">");
			for( int index=0; index<friend_list.getItemCount(); index++)
				out.print("<option value=\""+friend_list.getItem(index)+"\">"+friend_list.getItem(index)+"</option>");
			out.print("</select>");
			out.print("<span id=\"text_length\">140</span><textarea id=\"dm_text\" name=\"text_value\" onkeyup=\"CountNum()\"></textarea></form>");
			out.print("<div id=\"button_area\"><span id=\"send_button\"><a href=\"#\" onclick=\"sendMessage()\">send</a></span></div>");
			
		%>	
		</div>		
		<div id="messages">
			<%
				EachMessageInfo info;
			
				if( messages.listSize()!=0 )
				{
					for(int index=0; index<messages.listSize(); index++)	 //dm을 보낸 sender의 인원 = messages.listSize(); 
					{
						info = messages.elementAt(index);	//한 명의 sender가 보낸 dm의 정보를 가지는 EachMessageInfo 인스턴스 생
						String name = info.getName();
					//	User sender = twitter.showUser( name );		//sender의 이미지 출력시 필요함
					//twitter에 접근하여 sender(user)정보를 얻는 방식에서 sender가 보낸 dm 중 제일 처음 것에서 sender의 정보를 얻었다.
					//이는 twitter 객체에 접근하는 횟수를 줄이기 위함이다.
						User sender = info.getSender();
					
						out.print("<ul class=\"sender_list\" onclick=\"clickedSender('" +name+ "')\">");				
						out.print("<img class=\"sender_img\" src=\""+sender.getProfileImageURL()+"\"/>");	//최근에 보낸 dm에서 이미지 url을 꺼
						out.print("<li><span class=\"count\">"+info.getMessageSize()+"</span>");	//info의 vector에서 sender가 보낸 dm의 갯수 
						out.print("<span class=\"sender_name\">"+info.getName()+"</span></li>");
						out.print("</ul>");
						//dm의 size가 0인 경우에는 sender_list가 없으므로 따로 처리해줄 필요가 없다.
						out.print("<div id=\"dm_"+name+"\" class=\"div_dm\">");
					
						for( DirectMessage dm : info.getMessageList() )
						{							
							if( dm.getRecipientScreenName().equals( name ))	//수령인이 변수 name과 같다는 것은 user가 보낸것임을 나타
							{
								out.print("<ul class=\"sentDm_list\">");
								out.print("<img src=\""+dm.getSender().getProfileImageURL()+"\"/>");
								out.print("<li class=\"dm_date\">"+dm.getCreatedAt()+"</li>" );
								out.print("<li>"+dm.getText()+"</li>");
								out.print("<li class=\"dm_delete\"><a href=\"#\" id=\""+dm.getId()+"\" onclick=\"clickedDelete(id)\">delete</a></li>");
								out.print("</ul>");
							}else
							{
								out.print("<ul class=\"getDm_list\">");
								out.print("<img src=\""+dm.getSender().getProfileImageURL()+"\"/>");
								out.print("<li class=\"dm_date\">"+dm.getCreatedAt()+"</li>" );
								out.print("<li>"+dm.getText()+"</li>");
								out.print("<li class=\"dm_delete\"><a href=\"#\" id=\""+dm.getId()+"\" onclick=\"clickedDelete(id)\">delete</a></li>");
								out.print("</ul>");	
							}
						}
						out.print("<div class=\"page\">");
						out.print("<span class=\"page_button\" onclick=\"clickedPage('"+name+"', -1)\">pre</span>");
						out.print("<span id=\"page_"+name+"\">1</span>");
						out.print("<span class=\"page_button\" onclick=\"clickedPage('"+name+"', 1)\">next</span>");
				/*out.print("<span class=\"page_button\" onclick=\"clickedPage()\">[1]</span>");		//test
						if( info.getSize()/5 > 0)	//1페이지를 넘어가면 [2], [3], [4] 등등 출
						{
							for( int num=0; num<=info.getSize()/5; num++)
								out.print("<span class=\"page_button\" onclick=\"clickedPage('dm_"+name+"',"+num+")\">["+(num+1)+"]</span>");
					//		out.print("<input type=\"hidden\" name=\"hidden"+name+"\" value=\""+1+"\">");
						}*/
			
						out.print("</div>");
						out.print("</div>");
					}
				}else
					out.print("<span id=\"empty\">no message</span>");				
			%>
			<form method="post" id="info_form"></form>
		</div>
	</div>
	<div id="div_a">test</div>
	<div id="div_b">test</div> 
</body>
</html>