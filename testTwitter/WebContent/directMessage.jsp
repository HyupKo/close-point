<%@page import="Test.TimeLine.BasicForm"%>
<%@page import="twitter4j.TwitterException"%>
<%@page import="Test.TimeLine.EachMessageInfo"%>
<%@page import="Test.TimeLine.MessageList"%>
<%@page import="java.util.List"%>
<%@page import="twitter4j.DirectMessage"%>
<%@page import="twitter4j.Twitter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Twitter twitter = (Twitter)session.getAttribute("_twitter");

%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		@import "css/navigationBar.css";
		@import "css/directMessage.css";
	</style>
	<script type="text/javascript">

	
		function clickedSender(id)
		{
			var div_id = "dm_"+id;
			var content = document.getElementById(div_id);
			var dm_list = content.childNodes;
			var test = document.getElementById("div_aaa");
		//	test.innerHTML = dm_list.length;
			var index = 0;
			if( content.style.display == "none" )
			{
				content.style.display = "block";
				while( index< dm_list.length ) 
				{
						dm_list[index].style.display = "block";
				index++;
				}
			}else
			{
				content.style.display = "none";
				while( index<dm_list.length )
				{
					dm_list[index].style.display = "none";
					index++;
				}
			}
		}
	</script>
</head>
<body>
	<jsp:include page="navigationBar.jsp"></jsp:include>
	<div id="writing">
		<%
			
			out.print("<span class=\"recipient\"></span>");
		%>	
	</div>
	<div id="main">
		<%
			try
			{
				MessageList messages = new MessageList(twitter);		//dm결과를 sender마다 분
				
				EachMessageInfo info;
				DirectMessage dm;
			
				for(int index=0; index<messages.listSize(); index++)	 //dm을 보낸 sender의 인원 = messages.listSize(); 
				{
			//		System.out.println("[main] index: "+index);
					info = messages.elementAt(index);	//한 명의 sender가 보낸 dm의 정보를 가지는 EachMessageInfo 인스턴스 생
					dm = messages.getElement("get", info.getBasic(0));
					
					String name = info.getName();
			//		System.out.println("[main] get_list index: "+info.getBasic(0)); //test print
			//		System.out.println("[main] sender: "+dm.getSender().getScreenName() ); //test print
			//		System.out.println("[main] recipient: "+dm.getRecipient().getScreenName());
			//		System.out.println("[main] text: "+dm.getText());
					
					//infor.getBasic은 한 명의 sender에 대한 정보를 모아놓는 vector에서 index=0에 있는 값(get_list에서 가장 최근에 sender가 보낸 dm)을 
					//가져와 get_list에서 dm을 꺼내 sender에 대한 정보를 보여주기 위함. 					
				//		out.print("<div id=\"div_"+info.getName()+"\">");			//필요없어졌음
						out.print("<ul class=\"sender_list\" onclick=\"clickedSender('" +name+ "')\">");				
						out.print("<img class=\"sender_img\" src=\""+dm.getSender().getProfileImageURL()+"\">");	//최근에 보낸 dm에서 이미지 url을 꺼
						out.print("<li><span class=\"count\">"+info.getMessageSize()+"</span>");	//info의 vector에서 sender가 보낸 dm의 갯수 
						out.print("<span class=\"sender_name\">"+info.getName()+"</span></li>");
						out.print("</ul>");
						
						//dm의 size가 0인 경우에는 sender_list가 없으므로 따로 처리해줄 필요가 없다.
						out.print("<div id=\"dm_"+name+"\" class=\"div_dm\">");
						for( BasicForm basic : info.message_list)
						{
							dm = messages.getElement( "get", basic.getPublicIndex() );
							
							out.print("<ul class=\"dm_list\">");
							out.print("<li class=\"dm_date\">"+dm.getCreatedAt()+"</li>" );
							out.print("<li>"+dm.getText()+"</li>");
							out.print("<li class=\"dm_delete\"><a href=\"#\">delete</a></li>");
							out.print("</ul>");	
						}
					
						out.print("</div>");
				}
			
			}catch(TwitterException twitException)
			{
				System.out.println("TwitterException");
			}catch(NullPointerException nullException)
			{
				System.out.print("NullPointerException");
				nullException.printStackTrace();
			}
		%>
	</div>
	
	<div id="div_aaa">test</div>
	
	</div>

</body>
</html>