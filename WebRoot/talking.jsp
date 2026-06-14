<%@ page import="java.util.Date" contentType="text/html; charset=utf-8" %>
<%
  String guestnam = (String) session.getAttribute("nam0");
  if (guestnam == null) guestnam = "游客";

  String rawTalk = request.getParameter("txttalk");
  if (rawTalk == null) rawTalk = "";
  // HTML 转义防 XSS
  String safeTalk = rawTalk
      .replace("&","&amp;").replace("<","&lt;").replace(">","&gt;")
      .replace("\"","&quot;").replace("'","&#39;");

  String safeGuestnam = guestnam
      .replace("&","&amp;").replace("<","&lt;").replace(">","&gt;");

  String sentencestr = (String) application.getAttribute("sentence");
  int sentence = Integer.parseInt(sentencestr);
  for (int i = sentence; i >= 2; i--) {
    String talk = (String) application.getAttribute("talk" + (i - 1));
    application.setAttribute("talk" + i, talk);
  }

  Date dat = new Date();
  String tim = String.format("%02d:%02d:%02d", dat.getHours(), dat.getMinutes(), dat.getSeconds());

  // 消息气泡 HTML（与 frame0.jsp 的 .msg 样式对应）
  String talking =
      "<div class=\"msg\">" +
        "<div class=\"msg-header\">" +
          "<span class=\"msg-user\">" + safeGuestnam + "</span>" +
          "<span class=\"msg-time\">" + tim + "</span>" +
        "</div>" +
        "<div class=\"msg-body\">" + safeTalk + "</div>" +
      "</div>";

  application.setAttribute("talk1", talking);
  response.sendRedirect("frame0.jsp");
%>
