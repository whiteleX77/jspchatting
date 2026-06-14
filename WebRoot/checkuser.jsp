<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="utf-8"%>
<jsp:useBean id="db" class="bean.Dbcon" scope="request"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>登录验证</title>
<style>
*, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }
body {
  min-height: 100vh;
  background: #000;
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Display', system-ui, sans-serif;
  overflow: hidden;
}
.bg-blob {
  position: fixed; border-radius: 50%; filter: blur(100px);
  opacity: 0.18; pointer-events: none;
  animation: morphBlob 10s ease-in-out infinite alternate;
}
.b1 { width:500px; height:500px; background:#007AFF; top:-150px; left:-150px; animation-duration:12s; }
.b2 { width:400px; height:400px; background:#BF5AF2; bottom:-100px; right:-100px; animation-duration:9s; animation-delay:-4s; }
@keyframes morphBlob {
  0%   { border-radius: 60% 40% 30% 70% / 60% 30% 70% 40%; transform: translate(0,0) scale(1); }
  50%  { border-radius: 30% 60% 70% 40% / 50% 60% 30% 60%; transform: translate(20px,-20px) scale(1.05); }
  100% { border-radius: 50% 50% 30% 70% / 40% 60% 60% 40%; transform: translate(-10px,15px) scale(0.98); }
}
.card {
  position: relative; z-index: 10;
  width: 400px; padding: 44px 40px;
  background: rgba(255,255,255,0.05);
  backdrop-filter: blur(60px) saturate(180%);
  -webkit-backdrop-filter: blur(60px) saturate(180%);
  border: 1px solid rgba(255,255,255,0.1);
  border-radius: 28px;
  box-shadow: 0 40px 80px rgba(0,0,0,0.7), inset 0 1px 0 rgba(255,255,255,0.12);
  animation: slideUp .5s cubic-bezier(0.16,1,0.3,1) both;
  text-align: center;
}
@keyframes slideUp {
  from { opacity:0; transform:translateY(30px) scale(0.96); }
  to   { opacity:1; transform:translateY(0) scale(1); }
}
.island {
  display: inline-flex; align-items: center; gap: 8px;
  padding: 8px 20px; background: #111;
  border: 1px solid rgba(255,255,255,0.12); border-radius: 999px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.6), inset 0 1px 0 rgba(255,255,255,0.08);
  margin-bottom: 28px;
}
.island-dot { width:8px; height:8px; border-radius:50%; box-shadow:0 0 8px currentColor; }
.dot-ok  { background:#30D158; color:#30D158; }
.dot-err { background:#FF453A; color:#FF453A; }
.island-label { color:rgba(255,255,255,0.85); font-size:13px; font-weight:600; letter-spacing:.4px; }
.title { color:#fff; font-size:22px; font-weight:700; margin-bottom: 16px; }
.subtitle { color:rgba(255,255,255,0.45); font-size:14px; line-height:1.6; margin-bottom:8px; }
.info-row { color:rgba(255,255,255,0.5); font-size:13px; margin:6px 0; }
.info-row b { color:rgba(255,255,255,0.75); }
.btn {
  display: inline-block; margin-top: 28px;
  padding: 13px 32px;
  background: linear-gradient(135deg, #007AFF, #5856D6);
  border: none; border-radius: 14px;
  color: #fff; font-size: 15px; font-weight: 600; font-family: inherit;
  cursor: pointer; text-decoration: none;
  transition: transform .15s, box-shadow .15s;
  box-shadow: 0 6px 24px rgba(0,122,255,0.4);
}
.btn:hover { transform:translateY(-2px); box-shadow:0 10px 32px rgba(0,122,255,0.5); }
.btn-back {
  display: inline-block; margin-top: 20px;
  padding: 12px 28px;
  background: rgba(255,255,255,0.07);
  border: 1px solid rgba(255,255,255,0.1); border-radius: 14px;
  color: rgba(255,255,255,0.6); font-size: 14px; font-weight: 500; font-family: inherit;
  cursor: pointer; text-decoration: none;
  transition: background .2s;
}
.btn-back:hover { background: rgba(255,255,255,0.12); }
</style>
</head>
<body>
<div class="bg-blob b1"></div>
<div class="bg-blob b2"></div>
<%
  Connection con = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;
  try {
    con = db.getConnction();
    // 使用 PreparedStatement 防止 SQL 注入，同时验证密码
    pstmt = con.prepareStatement("SELECT * FROM user WHERE username = ? AND password = ?");
    pstmt.setString(1, request.getParameter("loginname"));
    pstmt.setString(2, request.getParameter("password"));
    rs = pstmt.executeQuery();

    if (!rs.next()) {
%>
<div class="card">
  <div class="island"><div class="island-dot dot-err"></div><span class="island-label">登录失败</span></div>
  <div class="title">用户名或密码错误</div>
  <div class="subtitle">数据库中没有找到匹配的用户，请检查用户名和密码后重试。</div>
  <a class="btn-back" href="index.jsp">返回重新登录</a>
</div>
<%
    } else {
      String guestname = rs.getString("name");
      String guestsex  = rs.getString("sex");
      session.setAttribute("name", guestname);
      session.setAttribute("sex",  guestsex);
      String opwin = "login.jsp?name=" + java.net.URLEncoder.encode(guestname, "UTF-8")
                   + "&sex="  + java.net.URLEncoder.encode(guestsex,  "UTF-8");
      // 对用户名做 HTML 转义，防止 XSS
      String safeGuestname = guestname.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;");
      String loginname = request.getParameter("loginname");
      if (loginname == null) loginname = "";
      String safeLoginname = loginname.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;");
%>
<div class="card">
  <div class="island"><div class="island-dot dot-ok"></div><span class="island-label">验证通过</span></div>
  <div class="title"><%= safeGuestname %> 同学，欢迎！</div>
  <div class="info-row">登录名：<b><%= safeLoginname %></b></div>
  <div class="info-row">IP 地址：<b><%= request.getRemoteAddr() %></b></div>
  <button class="btn" onclick="opwinfnc()">进入聊天室</button>
</div>
<script>
function opwinfnc() {
  window.open("<%=opwin%>", "chatroom", "toolbar=no,menubar=no,width=700,height=560");
}
</script>
<%
    }
  } finally {
    if (rs    != null) try { rs.close();    } catch(Exception e) {}
    if (pstmt != null) try { pstmt.close(); } catch(Exception e) {}
    if (con   != null) try { con.close();   } catch(Exception e) {}
  }
%>
</body>
</html>
