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

<Script type="text/javascript" src="http://apis.daum.net/maps/maps2.js?apikey=9ff735caefceafcda92cfb983847b997517e07ec"></script>
	<div id="content">
		<div>
		 	<span id="content_char">What's happening?</span> 
			<span id="content_length">140</span>
		</div>
		
		<div id="updateDiv">
			<form method="post" name="updateForm">
				<textarea id="content_text" name="text" rows="4" cols="35" onkeyup="CountNum()"></textarea>
				<input type="hidden" name="POINT_X" id="point_x"/>
				<input type="hidden" name="POINT_Y" id="point_y"/>
				<input type="hidden" name="PANO_ID" id="pano_id"/>
				<input type="hidden" name="PAN" id="pan"/>
				<input type="hidden" name="TILT" id="tilt"/>
			</form> 
		</div>
				
		<!-- 		<span id="map_able" onclick="insert_Daum_Map()">Insert Map</span>    -->
		<div id="content_map_text">			
			<div id="top_msg">
				<span id="map_able">Insert Map</span>
				<span id="search_add">주소&nbsp;&nbsp;:&nbsp;&nbsp;
					<input type="text"name="address" id="address"/>
					<input type="button" value="검색" onclick="select_pos();"/>
				</span>
			</div>
			<div id="sub_msg">
			</div>
			
<!-- 			<font size=3 color="red">※주소를 "동"이름으로 검색하세요.</font>		-->
				
			
			<div id="map">
			</div>
			
			<div id="road">
			</div>
		</div>
		
		<div id="content_map">
		</div>
		
		<div id="content_button">
			<span  id="button_able"><a href="#" onclick="actionSubmit()">tweet</a></span>
		</div>
	</div>

