<%@ page contentType="text/html; charset=utf-8" import="java.util.Date"%>
<%
    //取出在login.jsp页面存入的本人姓名和性别	
	String guestnam = (String) session.getAttribute("nam0");
	String guestsex = (String) session.getAttribute("sex0");
%>
<html>
<head><title>欢迎<%= guestnam%><%=guestsex%>生进入聊天室</title>
</head>
	<frameset cols="80%,*" >
		<frameset rows="60%,*">
			<frame src="frame0.jsp" name = fram0>
			<frame src="frame1.jsp" name = fram1>
		</frameset>
			<frame src="frame2.jsp" name=fram2 frameborder=0 scrolling=no>
	</frameset>
</html>
