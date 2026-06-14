<%@ page contentType="text/html; charset=utf-8" import="java.util.Date"%>
<%
  String guestnam = (String) session.getAttribute("nam0");
  if (guestnam == null) guestnam = "访客";
%>
<!DOCTYPE html>
<html lang="zh-CN" style="background:linear-gradient(-45deg,#f5f5f7,#e2d1f9,#e5f0fb,#d4e4f7);background-size:400% 400%;animation:fg 15s ease infinite;">
<head>
<meta charset="utf-8">
<title>聊天室 · <%= guestnam.replace("<","&lt;").replace(">","&gt;") %></title>
<style>@keyframes fg{0%{background-position:0% 50%}50%{background-position:100% 50%}100%{background-position:0% 50%}}</style>
</head>
<frameset cols="79%,21%"
          frameborder="0" border="0" framespacing="0">
  <frameset rows="65%,35%"
            frameborder="0" border="0" framespacing="0">
    <frame src="frame0.jsp" name="fram0" frameborder="0" scrolling="auto">
    <frame src="frame1.jsp" name="fram1" frameborder="0" scrolling="no">
  </frameset>
  <frame src="frame2.jsp" name="fram2" frameborder="0" scrolling="auto">
</frameset>
</html>
