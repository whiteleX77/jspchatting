<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%
  String reqname = request.getParameter("name");
  String reqsex  = request.getParameter("sex");
  if (reqname == null) reqname = "游客";
  if (reqsex  == null) reqsex  = "";

  String safeGuestname = reqname.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;");

  session.setAttribute("nam0", reqname);
  session.setAttribute("sex0", reqsex);

  int i = 0, talker = 0;
  Object talk = null, visitnam = null, visitsex = null;

  String talkerstr = (String) application.getAttribute("talker");
  if (talkerstr == null) {
    application.setAttribute("talker",   "1");
    application.setAttribute("sentence", "50");
  } else {
    talker = Integer.parseInt(talkerstr);
    application.setAttribute("talker", String.valueOf(talker + 1));
  }

  String sentencestr = (String) application.getAttribute("sentence");
  int sentence = Integer.parseInt(sentencestr);

  if (talker == 0) {
    for (i = 1; i <= sentence; i++) application.setAttribute("talk"     + i, "");
    for (i = 1; i <= sentence; i++) application.setAttribute("visitnam" + i, "");
    for (i = 1; i <= sentence; i++) application.setAttribute("visitsex" + i, "");
  } else {
    for (i = sentence; i >= 2; i--) {
      talk     = application.getAttribute("talk"     + (i - 1));
      visitnam = application.getAttribute("visitnam" + (i - 1));
      visitsex = application.getAttribute("visitsex" + (i - 1));
      application.setAttribute("talk"     + i, talk);
      application.setAttribute("visitnam" + i, visitnam);
      application.setAttribute("visitsex" + i, visitsex);
    }
  }

  application.setAttribute("visitnam1", reqname);
  application.setAttribute("visitsex1", reqsex);

  Date dat = new Date();
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  String tim = sdf.format(dat);

  String tking =
      "<div class=\"msg msg-system\">欢迎 <b>" + safeGuestname + "</b> 光临！光临时间：" + tim + "</div>";
  application.setAttribute("talk1", tking);

  response.sendRedirect("frame.jsp");
%>
