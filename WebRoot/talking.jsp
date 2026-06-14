<%@ page import="java.util.Date" contentType="text/html; charset=utf-8" %>
<%
  String guestnam = (String) session.getAttribute("nam0");
  if (guestnam == null) guestnam = "游客";

  // 对聊天内容做 HTML 转义，防止 XSS
  String rawTalk = request.getParameter("txttalk");
  if (rawTalk == null) rawTalk = "";
  String safeTalk = rawTalk
      .replace("&", "&amp;")
      .replace("<", "&lt;")
      .replace(">", "&gt;")
      .replace("\"", "&quot;")
      .replace("'", "&#39;");

  String safeGuestnam = guestnam
      .replace("&", "&amp;")
      .replace("<", "&lt;")
      .replace(">", "&gt;");

  // 将所有记录整体向后挪一位，为新消息腾出首位
  String sentencestr = (String) application.getAttribute("sentence");
  int sentence = Integer.parseInt(sentencestr);
  for (int i = sentence; i >= 2; i--) {
    String talk = (String) application.getAttribute("talk" + (i - 1));
    application.setAttribute("talk" + i, talk);
  }

  Date dat = new Date();
  String tim = String.format("%02d:%02d:%02d", dat.getHours(), dat.getMinutes(), dat.getSeconds());

  // 存为带样式 class 的 HTML，消息内容已转义
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
