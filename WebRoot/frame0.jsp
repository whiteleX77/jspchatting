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
  background: #050505;
  font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Text', system-ui, sans-serif;
  overflow-x: hidden;
  overflow-y: auto;
}

/* 细滚动条 */
::-webkit-scrollbar { width: 4px; }
::-webkit-scrollbar-track { background: transparent; }
::-webkit-scrollbar-thumb { background: rgba(255,255,255,0.13); border-radius:999px; }

/* 顶栏 */
.top-bar {
  position: sticky; top: 0; z-index: 20;
  padding: 10px 18px;
  background: rgba(5,5,5,0.82);
  backdrop-filter: blur(24px) saturate(180%);
  -webkit-backdrop-filter: blur(24px) saturate(180%);
  border-bottom: 1px solid rgba(255,255,255,0.06);
  display: flex;
  align-items: center;
  gap: 10px;
}

.top-island {
  display: inline-flex; align-items: center; gap: 6px;
  background: #111;
  border: 1px solid rgba(255,255,255,0.1);
  border-radius: 999px;
  padding: 5px 14px;
  box-shadow: 0 2px 12px rgba(0,0,0,0.5), inset 0 1px 0 rgba(255,255,255,0.07);
}
.top-dot {
  width: 6px; height: 6px;
  background: #30D158; border-radius: 50%;
  box-shadow: 0 0 6px #30D158;
  animation: blink 2s ease-in-out infinite;
}
@keyframes blink { 0%,100%{opacity:1} 50%{opacity:.35} }

.top-count { color: rgba(255,255,255,0.75); font-size: 12px; font-weight: 600; }
.top-label { color: rgba(255,255,255,0.3); font-size: 11px; }

/* 消息区 */
.messages {
  padding: 14px 18px 20px;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

/* 普通消息气泡 */
.msg {
  padding: 11px 15px;
  background: rgba(255,255,255,0.04);
  border: 1px solid rgba(255,255,255,0.07);
  border-radius: 15px;
  animation: msgIn .28s cubic-bezier(0.16,1,0.3,1) both;
}
@keyframes msgIn {
  from { opacity:0; transform:translateY(6px) scale(0.98); }
  to   { opacity:1; transform:translateY(0)   scale(1);    }
}

.msg-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 5px;
}
.msg-user  { color: #4DA3FF; font-size: 13px; font-weight: 600; }
.msg-time  { color: rgba(255,255,255,0.28); font-size: 11px; }
.msg-body  {
  color: rgba(255,255,255,0.82);
  font-size: 14px;
  line-height: 1.55;
  word-break: break-word;
}

/* 系统通知条 */
.msg-system {
  background: transparent;
  border: none;
  border-top: 1px solid rgba(255,255,255,0.05);
  border-bottom: 1px solid rgba(255,255,255,0.05);
  border-radius: 0;
  text-align: center;
  color: rgba(255,255,255,0.32);
  font-size: 12px;
  padding: 8px 16px;
}
.msg-system b { color: rgba(255,255,255,0.48); font-weight: 500; }
.msg-bye { color: rgba(255,69,58,0.5); }
.msg-bye b { color: rgba(255,69,58,0.65); }
</style>
</head>
<body>
<%
  String talkerstr  = (String) application.getAttribute("talker");
  String sentencestr = (String) application.getAttribute("sentence");
  if (talkerstr  == null) talkerstr  = "0";
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
