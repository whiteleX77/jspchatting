<%@ page contentType="text/html; charset=utf-8" import="java.util.Date"%>
<%
  String guestnam = (String) session.getAttribute("nam0");
  if (guestnam == null) guestnam = "访客";
  String guestsex = (String) session.getAttribute("sex0");
  if (guestsex == null) guestsex = "";
%>
<!DOCTYPE html>
<html lang="zh-CN" style="background:#000;">
<head>
<meta charset="utf-8">
<title>聊天室 · <%= guestnam.replace("<","&lt;").replace(">","&gt;") %> <%= guestsex %>生</title>
</head>
<frameset cols="79%,21%"
          frameborder="0" border="0" framespacing="0"
          style="background:#000;">
  <frameset rows="65%,35%"
            frameborder="0" border="0" framespacing="0">
    <frame src="frame0.jsp" name="fram0" frameborder="0" scrolling="auto">
    <frame src="frame1.jsp" name="fram1" frameborder="0" scrolling="no">
  </frameset>
  <frame src="frame2.jsp" name="fram2" frameborder="0" scrolling="auto">
</frameset>
</html>
