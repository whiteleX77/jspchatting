<%@ page import="java.util.*" contentType="text/html; charset=utf-8"%>
<%
  String errorCode = request.getParameter("error");
  String success   = request.getParameter("success");
  String initPanel = (errorCode != null) ? "register" : "login";
  String msgText = "", msgType = "";
  if ("1".equals(success)) {
    msgText = "注册成功，请登录 🎉";
    msgType = "success";
    initPanel = "login";
  } else if ("exists".equals(errorCode)) {
    msgText = "该用户名已被注册，请换一个";
    msgType = "error";
  } else if ("invalid".equals(errorCode)) {
    msgText = "请填写所有字段，且两次密码须一致";
    msgType = "error";
  } else if ("toolong".equals(errorCode)) {
    msgText = "用户名最多 15 字符，密码最多 10 字符";
    msgType = "error";
  } else if ("db".equals(errorCode)) {
    msgText = "服务器错误，请稍后再试";
    msgType = "error";
  }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>聊天室</title>
<style>
:root {
  --apple-blue:  #0071e3;
  --apple-green: #30d158;
  --apple-red:   #ff3b30;
  --glass-bg:    rgba(255,255,255,0.55);
  --glass-blur:  blur(28px) saturate(200%);
  --glass-border:1px solid rgba(255,255,255,0.78);
  --text-main:   #1d1d1f;
  --text-sec:    #6e6e73;
}
*, *::before, *::after { margin:0; padding:0; box-sizing:border-box; }

body {
  min-height:100vh;
  display:flex; align-items:center; justify-content:center;
  font-family:-apple-system, BlinkMacSystemFont, "SF Pro Display", system-ui, sans-serif;
  background:linear-gradient(-45deg, #f5f5f7, #e2d1f9, #e5f0fb, #d4e4f7);
  background-size:400% 400%;
  animation:fluidGradient 15s ease infinite, pageIn .55s cubic-bezier(0.16,1,0.3,1) both;
  overflow:hidden;
  -webkit-font-smoothing:antialiased;
}
@keyframes fluidGradient {
  0%  { background-position:0%   50%; }
  50% { background-position:100% 50%; }
  100%{ background-position:0%   50%; }
}
@keyframes pageIn {
  from{ opacity:0; transform:translateY(18px) scale(0.97); }
  to  { opacity:1; transform:none; }
}
@keyframes panelIn {
  from{ opacity:0; transform:translateY(12px); }
  to  { opacity:1; transform:none; }
}

.card {
  position:relative; z-index:10;
  width:380px;
  padding:46px 40px 50px;
  background:var(--glass-bg);
  backdrop-filter:var(--glass-blur);
  -webkit-backdrop-filter:var(--glass-blur);
  border:var(--glass-border);
  border-radius:28px;
  box-shadow:
    0 2px 0  rgba(255,255,255,0.92) inset,
    0 20px 50px rgba(0,0,0,0.07),
    0 1px  3px rgba(0,0,0,0.04);
  transition:height .35s cubic-bezier(0.16,1,0.3,1);
}

.island {
  display:flex; align-items:center; gap:8px;
  width:fit-content; margin:0 auto 36px;
  padding:10px 22px;
  background:rgba(0,0,0,0.86);
  border-radius:999px;
  box-shadow:0 4px 20px rgba(0,0,0,0.18);
  animation:islandFloat 4s ease-in-out infinite;
}
@keyframes islandFloat {
  0%,100%{ transform:translateY(0); }
  50%    { transform:translateY(-3px); }
}
.island-dot {
  width:8px; height:8px;
  background:var(--apple-green); border-radius:50%;
  box-shadow:0 0 8px var(--apple-green);
  animation:dotPulse 2s ease-in-out infinite;
}
@keyframes dotPulse{ 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:.4;transform:scale(.78)} }
.island-label{ color:rgba(255,255,255,0.92); font-size:13px; font-weight:600; letter-spacing:.5px; }

/* 消息提示 */
.msg-bar {
  display:none;
  padding:11px 16px; margin-bottom:20px;
  border-radius:12px; font-size:13px; font-weight:500;
  animation:panelIn .3s both;
}
.msg-bar.show { display:block; }
.msg-bar.success { background:rgba(48,209,88,0.12); color:#1a7f3c; border:1px solid rgba(48,209,88,0.28); }
.msg-bar.error   { background:rgba(255,59,48,0.09);  color:#c02a22; border:1px solid rgba(255,59,48,0.22); }

/* 面板 */
.panel { display:none; }
.panel.active { display:block; animation:panelIn .35s cubic-bezier(0.16,1,0.3,1) both; }

/* 表单 */
.field-label {
  display:block; margin-bottom:8px;
  color:var(--text-sec); font-size:11px; font-weight:700;
  letter-spacing:1px; text-transform:uppercase;
}
.field {
  width:100%; padding:14px 18px; margin-bottom:16px;
  background:rgba(255,255,255,0.7);
  border:1.5px solid rgba(0,0,0,0.08);
  border-radius:14px;
  color:var(--text-main); font-size:15px; font-family:inherit;
  outline:none;
  transition:border-color .22s, box-shadow .22s, background .22s;
  -webkit-appearance:none;
}
.field::placeholder{ color:rgba(0,0,0,0.25); }
.field:focus {
  background:rgba(255,255,255,0.9);
  border-color:var(--apple-blue);
  box-shadow:0 0 0 3.5px rgba(0,113,227,0.18);
}

/* 主按钮 */
.btn {
  width:100%; margin-top:8px;
  padding:15px;
  background:var(--apple-blue);
  border:none; border-radius:980px;
  color:#fff; font-size:15px; font-weight:600; font-family:inherit;
  cursor:pointer; position:relative; overflow:hidden;
  box-shadow:0 4px 18px rgba(0,113,227,0.38);
  transition:transform .15s, box-shadow .15s, background .15s;
}
.btn::after {
  content:''; position:absolute; inset:0;
  background:linear-gradient(135deg,rgba(255,255,255,0.18) 0%,transparent 55%);
  opacity:0; transition:opacity .2s;
}
.btn:hover  { background:#0077ed; transform:translateY(-2px); box-shadow:0 8px 28px rgba(0,113,227,0.42); }
.btn:hover::after { opacity:1; }
.btn:active { transform:translateY(0); box-shadow:0 3px 12px rgba(0,113,227,0.3); }

/* 切换链接 */
.switch-row {
  margin-top:20px; text-align:center;
  font-size:13px; color:var(--text-sec);
}
.switch-row a {
  color:var(--apple-blue); font-weight:600; text-decoration:none; cursor:pointer;
  transition:opacity .15s;
}
.switch-row a:hover{ opacity:.75; }
</style>
</head>
<body>
<div class="card">
  <div class="island">
    <div class="island-dot"></div>
    <span class="island-label">JSP 聊天室</span>
  </div>

  <%-- 消息提示条 --%>
  <div id="msgBar" class="msg-bar <%= msgType.isEmpty() ? "" : "show " + msgType %>">
    <%= msgText %>
  </div>

  <%-- 登录面板 --%>
  <div id="panel-login" class="panel">
    <form method="post" action="checkuser.jsp" onsubmit="return chkLogin()">
      <label class="field-label">用户名</label>
      <input type="text"     name="loginname" class="field" placeholder="请输入用户名" autocomplete="username">
      <label class="field-label">密码</label>
      <input type="password" name="password"  class="field" placeholder="请输入密码"   autocomplete="current-password">
      <button type="submit" class="btn">进入聊天室</button>
    </form>
    <div class="switch-row">还没有账号？<a onclick="switchTo('register')">立即注册</a></div>
  </div>

  <%-- 注册面板 --%>
  <div id="panel-register" class="panel">
    <form method="post" action="register.jsp" onsubmit="return chkRegister()">
      <label class="field-label">用户名</label>
      <input type="text"     name="name"     class="field" placeholder="最多 15 个字符"   autocomplete="username">
      <label class="field-label">密码</label>
      <input type="password" name="password" class="field" placeholder="最多 10 个字符"   autocomplete="new-password">
      <label class="field-label">确认密码</label>
      <input type="password" name="confirm"  class="field" placeholder="再次输入密码"     autocomplete="new-password">
      <button type="submit" class="btn">注册账号</button>
    </form>
    <div class="switch-row">已有账号？<a onclick="switchTo('login')">返回登录</a></div>
  </div>
</div>

<script>
var initPanel = '<%= initPanel %>';

function switchTo(panel) {
  document.getElementById('panel-login').classList.remove('active');
  document.getElementById('panel-register').classList.remove('active');
  document.getElementById('panel-' + panel).classList.add('active');
  // 切换面板时清除消息
  var bar = document.getElementById('msgBar');
  bar.className = 'msg-bar';
  bar.textContent = '';
}

function chkLogin() {
  var n = document.querySelector('#panel-login [name=loginname]').value.trim();
  var p = document.querySelector('#panel-login [name=password]').value;
  if (!n || !p) { alert('请输入用户名与密码！'); return false; }
  return true;
}

function chkRegister() {
  var n = document.querySelector('#panel-register [name=name]').value.trim();
  var p = document.querySelector('#panel-register [name=password]').value;
  var c = document.querySelector('#panel-register [name=confirm]').value;
  if (!n || !p || !c) { alert('请填写所有字段！'); return false; }
  if (p !== c) { alert('两次输入的密码不一致！'); return false; }
  if (n.length > 15) { alert('用户名最多 15 个字符！'); return false; }
  if (p.length > 10) { alert('密码最多 10 个字符！'); return false; }
  return true;
}

// 初始化显示对应面板
switchTo(initPanel);
// 如果有消息，重新显示（switchTo 会清除，所以这里手动恢复）
<%
  if (!msgText.isEmpty()) {
%>
document.getElementById('msgBar').className = 'msg-bar show <%= msgType %>';
document.getElementById('msgBar').textContent = '<%= msgText.replace("'", "\\'") %>';
<%
  }
%>
</script>
</body>
</html>
