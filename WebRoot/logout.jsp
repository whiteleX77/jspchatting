<%@ page contentType="text/html; charset=utf-8"
    import="java.util.Date,java.text.SimpleDateFormat"%>
<%
  String guestnam = (String) session.getAttribute("nam0");
  if (guestnam == null) guestnam = "游客";

  String safeGuestnam = guestnam
      .replace("&","&amp;").replace("<","&lt;").replace(">","&gt;");

  String sentencestr = (String) application.getAttribute("sentence");
  int sentence = Integer.parseInt(sentencestr);

  // 找到当前用户在 visitnam 数组中的位置
  int kint = 0;
  for (int i = 1; i <= sentence; i++) {
    String tmp = (String) application.getAttribute("visitnam" + i);
    if (tmp != null && tmp.equals(guestnam)) { kint = i; break; }
  }

  // 将其后的条目前移一位，填补空缺
  if (kint > 0) {
    for (int i = kint; i < sentence; i++) {
      application.setAttribute("visitnam" + i, application.getAttribute("visitnam" + (i + 1)));
      application.setAttribute("visitsex" + i, application.getAttribute("visitsex" + (i + 1)));
    }
    application.setAttribute("visitnam" + sentence, "");
    application.setAttribute("visitsex" + sentence, "");
  }

  // 将聊天记录向后挪一位，首位写入离开消息
  String talk;
  for (int i = sentence; i >= 2; i--) {
    talk = (String) application.getAttribute("talk" + (i - 1));
    application.setAttribute("talk" + i, talk);
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
body { background:#000; margin:0; }
</style>
<script>
window.onload = function() { self.close(); };
</script>
</head>
<body></body>
</html>
