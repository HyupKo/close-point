<%@page import="twitter4j.http.RequestToken"%>
<%@page import="twitter4j.Twitter"%>
<%@page import="comm.util.requestManager"%>
<%@page import="testTwitter.user.UserProc"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<style type="text/css">
	</style>
</head>
<body>
<%
	UserProc users = new UserProc();
	if( users.checkMailAdd(request.getParameter("USER_EMAIL")) )
	{
		if( users.checkTwitID(request.getParameter("USER_TWITTER_ID")) )
		{
			String result = users.checkUserStatusInfo(request);
			
			if(result == "SUCCESS")
			{
				String result2 = users.regist_user(requestManager.getRequest(request));
				if(result2=="SUCCESS")
				{
					%>
					<div><p>회원가입이 완료되었습니다. </p><span><a href="../timeLine.jsp">Home</a></span></div>
					<%
				}
				else
				{
					%>
						<div><p>오류메시지 : <%=result2 %></p><span><a href="../join.jsp">RETRY</a></span></div>
					<%
				}
			}
			else 
			{
				%>
				<div><p>오류메시지 : <%=result %></p><span><a href="../join.jsp">RETRY</a></span></div>
				<%
			}
		}else
		{
			%>
			
			<div><p>이미 존재하는 트위터아이디입니다.</p><span><a href="../index.jsp">Home</a></span></div>
			<%
		}
	}else
	{
		%>
		<div><p>이미 존재하는 이메일주소입니다.</p><span><a href="../join.jsp">RETRY</a></span></div>
		<%
	}
	%>
</body>
</html>