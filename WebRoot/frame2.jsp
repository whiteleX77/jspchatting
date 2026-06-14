<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="refresh" content="5">
<style>
*, *::before, *::after { margin:0; padding:0; box-sizing:border-box; }

html, body {
  height: 100%;
  background: #060606;
  font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Text', system-ui, sans-serif;
  border-left: 1px solid rgba(255,255,255,0.07);
  overflow-y: auto;
  overflow-x: hidden;
}

::-webkit-scrollbar { width: 3px; }
::-webkit-scrollbar-thumb { background: rgba(255,255,255,0.1); border-radius:999px; }

.sidebar { padding: 16px 12px; }

/* 标题区 */
.sidebar-header {
  display: flex;
  flex-direction: column;
  gap: 10px;
  padding-bottom: 14px;
  border-bottom: 1px solid rgba(255,255,255,0.06);
  margin-bottom: 14px;
}

.island-badge {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  background: #0d0d0d;
  border: 1px solid rgba(255,255,255,0.1);
  border-radius: 999px;
  padding: 5px 12px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.5), inset 0 1px 0 rgba(255,255,255,0.06);
  animation: glow 3s ease-in-out infinite;
}
@keyframes glow {
  0%,100% { box-shadow: 0 2px 10px rgba(0,0,0,.5), inset 0 1px 0 rgba(255,255,255,.06); }
  50%      { box-shadow: 0 2px 10px rgba(0,0,0,.5), inset 0 1px 0 rgba(255,255,255,.06), 0 0 16px rgba(48,209,88,.18); }
}

.badge-dot {
  width: 6px; height: 6px;
  background: #30D158; border-radius: 50%;
  box-shadow: 0 0 6px #30D158;
  animation: blink 2s ease-in-out infinite;
}
@keyframes blink { 0%,100%{opacity:1} 50%{opacity:.3} }

.badge-count { color: #30D158; font-size: 12px; font-weight: 700; }
.section-title {
  color: rgba(255,255,255,0.3);
  font-size: 10px;
  font-weight: 700;
  letter-spacing: 1.2px;
  text-transform: uppercase;
}

/* 用户卡片 */
.user-card {
  display: flex;
  align-items: center;
  gap: 9px;
  padding: 9px 10px;
  border-radius: 13px;
  margin-bottom: 6px;
  background: rgba(255,255,255,0.04);
  border: 1px solid rgba(255,255,255,0.05);
  transition: background .2s, transform .2s;
  animation: slideIn .3s cubic-bezier(0.16,1,0.3,1) both;
}
.user-card:hover { background: rgba(255,255,255,0.08); transform: translateX(2px); }

@keyframes slideIn {
  from { opacity:0; transform:translateX(10px); }
  to   { opacity:1; transform:translateX(0);    }
}

.avatar {
  flex-shrink: 0;
  width: 32px; height: 32px;
  border-radius: 50%;
  display: flex; align-items: center; justify-content: center;
  font-size: 13px; font-weight: 700; color: #fff;
  box-shadow: 0 2px 8px rgba(0,0,0,0.4);
}
.avatar-male   { background: linear-gradient(135deg, #007AFF, #5856D6); }
.avatar-female { background: linear-gradient(135deg, #FF375F, #BF5AF2); }

.user-info { flex: 1; min-width: 0; }
.user-name {
  color: rgba(255,255,255,0.82);
  font-size: 13px;
  font-weight: 500;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.user-sex {
  color: rgba(255,255,255,0.3);
  font-size: 11px;
  margin-top: 1px;
}
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
    String vsex = (String) application.getAttribute("visitsex" + i);
    if (vnam == null || vnam.trim().isEmpty()) continue;
    String safeName = vnam.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;");
    String initial   = vnam.length() > 0 ? String.valueOf(vnam.charAt(0)) : "?";
    boolean isFemale = "女".equals(vsex);
%>
  <div class="user-card">
    <div class="avatar <%= isFemale ? "avatar-female" : "avatar-male" %>"><%= initial %></div>
    <div class="user-info">
      <div class="user-name"><%= safeName %></div>
      <div class="user-sex"><%= isFemale ? "女生" : "男生" %></div>
    </div>
  </div>
<%
  }
%>
</div>
</body>
</html>
