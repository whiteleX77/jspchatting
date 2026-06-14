<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="refresh" content="5">
<style>
:root {
  --apple-blue: #0071e3;
  --text-main:  #1d1d1f;
  --text-sec:   #6e6e73;
}
*, *::before, *::after { margin:0; padding:0; box-sizing:border-box; }

html, body {
  height:100%;
  font-family: -apple-system, BlinkMacSystemFont, "SF Pro Text", system-ui, sans-serif;
  background: rgba(255,255,255,0.5);
  backdrop-filter: blur(20px) saturate(200%);
  -webkit-backdrop-filter: blur(20px) saturate(200%);
  border-left: 1px solid rgba(0,0,0,0.07);
  overflow-y:auto; overflow-x:hidden;
  -webkit-font-smoothing:antialiased;
}
::-webkit-scrollbar { width:4px; }
::-webkit-scrollbar-thumb { background:rgba(0,0,0,0.1); border-radius:999px; }

.sidebar { padding:18px 12px; }

/* 标题区 */
.sidebar-header {
  padding-bottom:14px;
  border-bottom:1px solid rgba(0,0,0,0.07);
  margin-bottom:14px;
  display:flex; flex-direction:column; gap:10px;
}
/* 灵动岛徽章 */
.island-badge {
  display:inline-flex; align-items:center; gap:6px;
  background:rgba(0,0,0,0.83); border-radius:999px;
  padding:5px 12px;
  box-shadow:0 2px 10px rgba(0,0,0,0.12);
  animation:islandGlow 3s ease-in-out infinite;
}
@keyframes islandGlow {
  0%,100%{box-shadow:0 2px 10px rgba(0,0,0,.12)}
  50%    {box-shadow:0 2px 16px rgba(48,209,88,.3)}
}
.badge-dot  { width:6px;height:6px;background:#30d158;border-radius:50%;box-shadow:0 0 6px #30d158;animation:blink 2s ease-in-out infinite; }
@keyframes blink{0%,100%{opacity:1}50%{opacity:.3}}
.badge-count { color:#30d158; font-size:12px; font-weight:700; }
.section-title { color:var(--text-sec); font-size:10px; font-weight:700; letter-spacing:1.2px; text-transform:uppercase; }

/* 用户卡片 */
.user-card {
  display:flex; align-items:center; gap:9px;
  padding:9px 10px; border-radius:14px; margin-bottom:6px;
  background:rgba(255,255,255,0.65);
  border:1px solid rgba(255,255,255,0.9);
  box-shadow:0 2px 8px rgba(0,0,0,0.04);
  transition:transform .2s, box-shadow .2s, background .2s;
  animation:slideIn .3s cubic-bezier(0.16,1,0.3,1) both;
}
.user-card:hover { background:rgba(255,255,255,0.9); transform:translateX(3px); box-shadow:0 4px 14px rgba(0,0,0,0.07); }
@keyframes slideIn { from{opacity:0;transform:translateX(12px)} to{opacity:1;transform:none} }

.avatar {
  flex-shrink:0; width:32px; height:32px; border-radius:50%;
  display:flex; align-items:center; justify-content:center;
  font-size:13px; font-weight:700; color:#fff;
  background:linear-gradient(135deg, #007aff, #5856d6);
  box-shadow:0 2px 8px rgba(0,122,255,0.3);
}

.user-name { color:var(--text-main); font-size:13px; font-weight:500; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }
</style>
</head>
<body>
<div class="sidebar">
  <div class="sidebar-header">
<%
  String talkerstr = (String) application.getAttribute("talker");
  if (talkerstr == null) talkerstr = "0";
  int talker = Integer.parseInt(talkerstr);
%>
    <div class="island-badge">
      <div class="badge-dot"></div>
      <span class="badge-count"><%= talker %></span>
    </div>
    <div class="section-title">在线成员</div>
  </div>

<%
  for (int i = 1; i <= talker; i++) {
    String vnam = (String) application.getAttribute("visitnam" + i);
    if (vnam == null || vnam.trim().isEmpty()) continue;
    String safeName = vnam.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;");
    String initial  = vnam.length() > 0 ? String.valueOf(vnam.charAt(0)) : "?";
%>
  <div class="user-card">
    <div class="avatar"><%= initial %></div>
    <div class="user-name"><%= safeName %></div>
  </div>
<%
  }
%>
</div>
</body>
</html>
