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
  --glass-bg:   rgba(255,255,255,0.55);
  --glass-blur: blur(24px) saturate(200%);
  --glass-border: 1px solid rgba(255,255,255,0.75);
}
*, *::before, *::after { margin:0; padding:0; box-sizing:border-box; }

html, body {
  height: 100%;
  font-family: -apple-system, BlinkMacSystemFont, "SF Pro Text", system-ui, sans-serif;
  background: linear-gradient(-45deg, #f5f5f7, #e2d1f9, #e5f0fb, #d4e4f7);
  background-size: 400% 400%;
  animation: fluidGradient 15s ease infinite;
  overflow-x: hidden; overflow-y: auto;
  -webkit-font-smoothing: antialiased;
}
@keyframes fluidGradient { 0%{background-position:0% 50%} 50%{background-position:100% 50%} 100%{background-position:0% 50%} }

::-webkit-scrollbar { width: 5px; }
::-webkit-scrollbar-track { background: transparent; }
::-webkit-scrollbar-thumb { background: rgba(0,0,0,0.12); border-radius:999px; }

/* 顶栏 */
.top-bar {
  position: sticky; top:0; z-index:20;
  padding: 10px 18px;
  background: rgba(245,245,247,0.75);
  backdrop-filter: var(--glass-blur);
  -webkit-backdrop-filter: var(--glass-blur);
  border-bottom: 1px solid rgba(0,0,0,0.06);
  display:flex; align-items:center; gap:10px;
}
.top-island {
  display:inline-flex; align-items:center; gap:6px;
  background:rgba(0,0,0,0.83); border-radius:999px;
  padding:5px 14px;
  box-shadow:0 2px 10px rgba(0,0,0,0.15);
}
.top-dot {
  width:6px; height:6px; background:#30d158; border-radius:50%;
  box-shadow:0 0 6px #30d158; animation:blink 2s ease-in-out infinite;
}
@keyframes blink{0%,100%{opacity:1}50%{opacity:.3}}
.top-count { color:rgba(255,255,255,0.88); font-size:12px; font-weight:600; }
.top-label { color:var(--text-sec); font-size:11px; font-weight:500; }

/* 消息列表 */
.messages { padding:14px 18px 22px; display:flex; flex-direction:column; gap:8px; }

/* 普通消息气泡 */
.msg {
  padding:12px 16px;
  background: rgba(255,255,255,0.62);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border: 1px solid rgba(255,255,255,0.82);
  border-radius: 18px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.04), 0 1px 0 rgba(255,255,255,0.9) inset;
  animation: msgIn .28s cubic-bezier(0.16,1,0.3,1) both;
  transition: box-shadow .2s, transform .2s;
}
.msg:hover { box-shadow:0 6px 20px rgba(0,0,0,0.07); transform:translateY(-1px); }
@keyframes msgIn {
  from { opacity:0; transform:translateY(6px) scale(0.98); }
  to   { opacity:1; transform:none; }
}
.msg-header { display:flex; align-items:center; gap:8px; margin-bottom:5px; }
.msg-user   { color:var(--apple-blue); font-size:13px; font-weight:700; }
.msg-time   { color:var(--text-sec); font-size:11px; }
.msg-body   { color:var(--text-main); font-size:14px; line-height:1.55; word-break:break-word; }

/* 系统通知 */
.msg-system {
  background: rgba(0,0,0,0.04);
  backdrop-filter: none;
  border: 1px solid rgba(0,0,0,0.05);
  border-radius: 10px;
  text-align:center;
  color:var(--text-sec); font-size:12px;
  padding:7px 16px;
  box-shadow:none;
}
.msg-system:hover { transform:none; box-shadow:none; }
.msg-system b { color:var(--text-main); font-weight:500; }
.msg-bye { color:#ff453a; }
.msg-bye b { color:#c02a22; }
</style>
</head>
<body>
<%
  String talkerstr   = (String) application.getAttribute("talker");
  String sentencestr = (String) application.getAttribute("sentence");
  if (talkerstr   == null) talkerstr   = "0";
  if (sentencestr == null) sentencestr = "50";
  int sentence = Integer.parseInt(sentencestr);
%>
<div class="top-bar">
  <div class="top-island">
    <div class="top-dot"></div>
    <span class="top-count"><%= talkerstr %> 人在线</span>
  </div>
  <span class="top-label">聊天室实时消息</span>
</div>
<div class="messages">
<%
  for (int i = 1; i <= sentence; i++) {
    Object talk = application.getAttribute("talk" + i);
    if (talk != null && !talk.toString().trim().isEmpty()) {
%>
<%= talk %>
<%
    }
  }
%>
</div>
</body>
</html>
