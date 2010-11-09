<%@page import="java.util.HashMap"%>
<%@page import="twitter4j.Twitter"%>
<%@page import="Test.TimeLine.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
/*
	twitter에 글 올리기!!!
*/
		Twitter twitter = (Twitter)session.getAttribute("_twitter");
//		HashMap hm = new HashMap();  											not use?
		
		UpdateStatus instance_update = new UpdateStatus();
		instance_update.setTwitterInstance(twitter);
		
		// If we wanna use Korean, we should use this code. (if not, Korean is not work in Twitter.com)

		String char_set = request.getCharacterEncoding();
		System.out.println(char_set);
		
//		hm = (HashMap)request.getParameterMap();            			
//		System.out.println("Check here!!!");										

		String parameter = request.getParameter("text");
		System.out.println(parameter);

		if( parameter!=null )
		{
			instance_update.setStatus( parameter );
		}
		else if( parameter==null )
		{
			System.out.println("parameter is empty!!!");
		}
/*	
	
	------------**  We can create a HashMap instance to maintain parameters easily. **
		if(!hm.isEmpty())
		{
			for(int i=0 ; i<hm.size() ; i++)
			{
				System.out.println((String)hm.get(i));
			}
		}
		else if(hm.isEmpty())
		{
			System.out.println("Parameter is empty!!!");
		}
	------------**  We can create a HashMap instance to maintain parameters easily. **
*/
		
%>
	<div id="content">
		<div>
		 	<span id="content_char">What's happening?</span> 
			<span id="content_length">140</span>
		</div>
		
		<div>
			<form method="post" name="updateForm">
				<textarea id="content_text" name="text" rows="4" cols="35" onkeyup="CountNum()"></textarea>
			</form> 
		</div>
		
		<div id="content_button">
			<span  id="button_able"><a href="#" onclick="actionSubmit()">tweet</a></span>
		</div>
	</div>

