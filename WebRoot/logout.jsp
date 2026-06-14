<%@ page contentType="text/html; charset=utf-8"
    import="java.util.Date,java.text.SimpleDateFormat"%>
<%
  String guestnam = (String) session.getAttribute("nam0");
  if (guestnam == null) guestnam = "游客";
  String safeGuestnam = guestnam.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;");

  String sentencestr = (String) application.getAttribute("sentence");
  int sentence = Integer.parseInt(sentencestr);

  // 找到当前用户在 visitnam 数组中的位置
  int kint = 0;
  for (int i = 1; i <= sentence; i++) {
    String tmp = (String) application.getAttribute("visitnam" + i);
    if (tmp != null && tmp.equals(guestnam)) { kint = i; break; }
  }

  // 将其后条目前移，填补空缺（修复原始越界问题）
  if (kint > 0) {
    for (int i = kint; i < sentence; i++) {
      application.setAttribute("visitnam" + i, application.getAttribute("visitnam" + (i + 1)));
      application.setAttribute("visitsex" + i, application.getAttribute("visitsex" + (i + 1)));
    }
    application.setAttribute("visitnam" + sentence, "");
    application.setAttribute("visitsex" + sentence, "");
  }

  // 聊天记录后移，首位写入离开消息
  for (int i = sentence; i >= 2; i--) {
    application.setAttribute("talk" + i, application.getAttribute("talk" + (i - 1)));
  }
  Date dat = new Date();
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  String tim = sdf.format(dat);

  String tking =
      "<div class=\"msg msg-system msg-bye\">谢谢 <b>" + safeGuestnam + "</b> 光顾！离开时间：" + tim + "</div>";
  application.setAttribute("talk1", tking);

  String talkerstr = (String) application.getAttribute("talker");
  int talker = Integer.parseInt(talkerstr);
  if (talker > 0) application.setAttribute("talker", String.valueOf(talker - 1));
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<style>
body { background: linear-gradient(-45deg,#f5f5f7,#e2d1f9,#e5f0fb,#d4e4f7); background-size:400% 400%; animation:fg 15s ease infinite; margin:0; }
@keyframes fg{0%{background-position:0% 50%}50%{background-position:100% 50%}100%{background-position:0% 50%}}
</style>
<script>window.onload = function() { self.close(); };</script>
</head>
<body></body>
</html>
