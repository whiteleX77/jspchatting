<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="utf-8"%>
<jsp:useBean id="db" class="bean.Dbcon" scope="request"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>登录验证</title>
<style>
:root {
  --apple-blue: #0071e3;
  --glass-bg: rgba(255,255,255,0.55);
  --glass-blur: blur(28px) saturate(200%);
  --glass-border: 1px solid rgba(255,255,255,0.78);
  --text-main: #1d1d1f;
  --text-sec: #6e6e73;
}
*, *::before, *::after { margin:0; padding:0; box-sizing:border-box; }
body {
  min-height: 100vh;
  display: flex; align-items: center; justify-content: center;
  font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", system-ui, sans-serif;
  background: linear-gradient(-45deg, #f5f5f7, #e2d1f9, #e5f0fb, #d4e4f7);
  background-size: 400% 400%;
  animation: fluidGradient 15s ease infinite, pageIn .5s cubic-bezier(0.16,1,0.3,1) both;
  overflow: hidden;
}
@keyframes fluidGradient { 0%{background-position:0% 50%} 50%{background-position:100% 50%} 100%{background-position:0% 50%} }
@keyframes pageIn { from{opacity:0;transform:translateY(20px) scale(0.97)} to{opacity:1;transform:none} }

.card {
  width: 420px; padding: 44px 40px;
  background: var(--glass-bg);
  backdrop-filter: var(--glass-blur);
  -webkit-backdrop-filter: var(--glass-blur);
  border: var(--glass-border);
  border-radius: 28px;
  box-shadow: 0 20px 50px rgba(0,0,0,0.08), 0 2px 0 rgba(255,255,255,0.9) inset;
  text-align: center;
}
/* 灵动岛胶囊（保持深色是原汁原味） */
.island {
  display: inline-flex; align-items: center; gap: 8px;
  padding: 9px 20px; background: rgba(0,0,0,0.86);
  border-radius: 999px; margin-bottom: 28px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.2);
}
.island-dot { width:8px; height:8px; border-radius:50%; animation: blink 2s ease-in-out infinite; }
.dot-ok  { background:#30d158; box-shadow:0 0 8px #30d158; }
.dot-err { background:#ff453a; box-shadow:0 0 8px #ff453a; }
.island-label { color:rgba(255,255,255,0.9); font-size:13px; font-weight:600; letter-spacing:.4px; }
@keyframes blink { 0%,100%{opacity:1} 50%{opacity:.35} }

.title   { color:var(--text-main); font-size:22px; font-weight:700; margin-bottom:10px; letter-spacing:-.4px; }
.subtitle{ color:var(--text-sec);  font-size:14px; line-height:1.6; margin-bottom:6px; }
.info-row{ color:var(--text-sec);  font-size:13px; margin:6px 0; }
.info-row b { color:var(--text-main); font-weight:600; }

.btn {
  display:inline-block; margin-top:28px; padding:13px 36px;
  background: var(--apple-blue); border:none; border-radius:980px;
  color:#fff; font-size:15px; font-weight:600; font-family:inherit; cursor:pointer;
  box-shadow: 0 4px 16px rgba(0,113,227,0.35);
  transition: transform .15s, box-shadow .15s, background .15s;
}
.btn:hover { background:#0077ed; transform:translateY(-2px); box-shadow:0 8px 24px rgba(0,113,227,0.4); }

.btn-back {
  display:inline-block; margin-top:20px; padding:12px 28px;
  background:rgba(0,0,0,0.06); border:none; border-radius:980px;
  color:var(--text-sec); font-size:14px; font-weight:500; font-family:inherit; cursor:pointer;
  text-decoration:none; transition:background .2s;
}
.btn-back:hover { background:rgba(0,0,0,0.1); }
</style>
</head>
<body>
<%
  Connection con = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;
  try {
    con = db.getConnction();
    // 实际列名为 name（无 username 列），使用 PreparedStatement 防 SQL 注入
    pstmt = con.prepareStatement("SELECT * FROM user WHERE name = ? AND password = ?");
    pstmt.setString(1, request.getParameter("loginname"));
    pstmt.setString(2, request.getParameter("password"));
    rs = pstmt.executeQuery();

    if (!rs.next()) {
%>
<div class="card">
  <div class="island"><div class="island-dot dot-err"></div><span class="island-label">登录失败</span></div>
  <div class="title">用户名或密码错误</div>
  <div class="subtitle">请检查你的登录名和密码后重试。</div>
  <a class="btn-back" href="index.jsp">返回登录</a>
</div>
<%
    } else {
      String guestname = rs.getString("name");
      // 数据库无 sex 字段，默认传空
      String guestsex = "";
      session.setAttribute("name", guestname);
      session.setAttribute("sex",  guestsex);
      String opwin = "login.jsp?name=" + java.net.URLEncoder.encode(guestname, "UTF-8")
                   + "&sex=" + java.net.URLEncoder.encode(guestsex, "UTF-8");
      String safeGuestname = guestname.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;");
      String loginname = request.getParameter("loginname");
      if (loginname == null) loginname = "";
      String safeLoginname = loginname.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;");
%>
<div class="card">
  <div class="island"><div class="island-dot dot-ok"></div><span class="island-label">验证通过</span></div>
  <div class="title"><%= safeGuestname %>，欢迎回来！</div>
  <div class="info-row">登录名：<b><%= safeLoginname %></b></div>
  <div class="info-row">IP 地址：<b><%= request.getRemoteAddr() %></b></div>
  <button class="btn" onclick="opwinfnc()">进入聊天室</button>
</div>
<script>
function opwinfnc() {
  window.open("<%=opwin%>", "chatroom", "toolbar=no,menubar=no,width=720,height=580");
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
