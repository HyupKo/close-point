<%@page import="twitter4j.Status"%>
<%@page import="java.util.List"%>

<%@page import="twitter4j.http.AccessToken"%>
<%@page import="twitter4j.TwitterFactory"%>
<%@page import="twitter4j.Twitter"%>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<html>
<head>
<title>simsimcoco</title>
<style>
	table
	{  
		 border-collapse: collapse; 
		 width: 700px;   
	}
	
	th, td
	{  
		 border: 1px solid lightblue;   
	} 
	
	#user_image
	{
		width: 50px;
		height: 50px;
		padding : 5px 5px;	
		
	}
	
	#date
	{
		 text-align: right;
	}
	
	
</style>
</head>
<body>

<%
	final String CONSUMER_KEY = "VUjKXVLvKbeHZZTMbXrsQg";
	final String CONSUMER_SECRET = "qaQ2S7e7b2x5BmbEjUcxSiC6tcOCDD0O938EvDRhPQ";
	final String TOKEN="173042297-rIclWiTBphLXIMkBC8O3xRaKmZ8hsaEbkO8nE3vA";
	final String TOKEN_SECRET="tt3MrZDwoG64LL76A7YF5VnhwyZNttK8Zs3sBO9qwt0";

	Twitter tw = new TwitterFactory().getInstance("jeongnon", "as2828");
//	Twitter twitter = new TwitterFactory().getInstance("jeongnon", "as2828");
//	Twitter twitter = new TwitterFactory().getOAuthAuthorizedInstance(CONSUMER_KEY, CONSUMER_SECRET
//			                                                                                      , new AccessToken(TOKEN, TOKEN_SECRET));

	tw.updateStatus("냐하하하하하");
//    List<Status> timeLine = twitter.getHomeTimeline();	
 /*   System.out.println("Showing friends timeline.");
    for (Status status : statuses) {
        out.print("<img src=\"" + status.getUser().getProfileImageURL() + "\">");
    	out.print(status.getUser().getName() + "&nbsp;&nbsp;:&nbsp;&nbsp;" +
                           status.getText() + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + status.getUser().getProfileImageURL());
        out.print("<br/>");
        
    }
*/
	
%>

        <%/*
        for( Status status : timeLine)
        {
        	out.print("<table>");
            out.print("<tr><td id=\"user_image\"rowspan=\"2\"><img src=\""+status.getUser().getProfileImageURL()+"\"></td>");
            out.print( "<td id=\"user_id\">"+status.getUser().getScreenName()+"</td>" );
            out.print("<tr><td>"+status.getText()+"</td></tr>");
            out.print("<tr><td id=\"date\" colspan=\"2\">"+status.getCreatedAt()+"&nbsp;via&nbsp;"+status.getSource()+"</td></tr>");
            out.print("</table><br/>");
        }
       */
        %>
    </table>
</body>
</html>





