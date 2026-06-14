<%@ page import="java.util.*" contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>聊天室</title>
<style>
:root {
  --apple-blue: #0071e3;
  --glass-bg: rgba(255,255,255,0.55);
  --glass-blur: blur(28px) saturate(200%);
  --glass-border: 1px solid rgba(255,255,255,0.78);
  --text-main: #1d1d1f;
  --text-sec:  #6e6e73;
}
*, *::before, *::after { margin:0; padding:0; box-sizing:border-box; }

body {
  min-height: 100vh;
  display: flex; align-items: center; justify-content: center;
  font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", system-ui, sans-serif;
  /* 液态流动渐变背景 */
  background: linear-gradient(-45deg, #f5f5f7, #e2d1f9, #e5f0fb, #d4e4f7);
  background-size: 400% 400%;
  animation: fluidGradient 15s ease infinite, pageIn .55s cubic-bezier(0.16,1,0.3,1) both;
  overflow: hidden;
  -webkit-font-smoothing: antialiased;
}

@keyframes fluidGradient {
  0%   { background-position: 0%   50%; }
  50%  { background-position: 100% 50%; }
  100% { background-position: 0%   50%; }
}
@keyframes pageIn {
  from { opacity:0; transform:translateY(18px) scale(0.97); }
  to   { opacity:1; transform:none; }
}

/* 毛玻璃卡片 */
.card {
  position: relative; z-index: 10;
  width: 380px;
  padding: 46px 40px 50px;
  background: var(--glass-bg);
  backdrop-filter: var(--glass-blur);
  -webkit-backdrop-filter: var(--glass-blur);
  border: var(--glass-border);
  border-radius: 28px;
  box-shadow:
    0 2px 0  rgba(255,255,255,0.92) inset,
    0 20px 50px rgba(0,0,0,0.07),
    0 1px  3px rgba(0,0,0,0.04);
}

/* 灵动岛胶囊（深色，正宗 Dynamic Island） */
.island {
  display: flex; align-items: center; gap: 8px;
  width: fit-content; margin: 0 auto 36px;
  padding: 10px 22px;
  background: rgba(0,0,0,0.86);
  border-radius: 999px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.18);
  animation: islandFloat 4s ease-in-out infinite;
}
@keyframes islandFloat {
  0%,100% { transform: translateY(0); }
  50%      { transform: translateY(-3px); }
}

.island-dot {
  width:8px; height:8px;
  background: #30d158; border-radius:50%;
  box-shadow: 0 0 8px #30d158;
  animation: dotPulse 2s ease-in-out infinite;
}
@keyframes dotPulse { 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:.4;transform:scale(.78)} }

.island-label { color:rgba(255,255,255,0.92); font-size:13px; font-weight:600; letter-spacing:.5px; }

/* 表单元素 */
.field-label {
  display:block; margin-bottom:8px;
  color:var(--text-sec); font-size:11px; font-weight:700;
  letter-spacing:1px; text-transform:uppercase;
}
.field {
  width:100%; padding:14px 18px; margin-bottom:16px;
  background: rgba(255,255,255,0.7);
  border: 1.5px solid rgba(0,0,0,0.08);
  border-radius: 14px;
  color: var(--text-main); font-size:15px; font-family:inherit;
  outline:none;
  transition: border-color .22s, box-shadow .22s, background .22s;
  -webkit-appearance: none;
}
.field::placeholder { color:rgba(0,0,0,0.25); }
.field:focus {
  background: rgba(255,255,255,0.9);
  border-color: var(--apple-blue);
  box-shadow: 0 0 0 3.5px rgba(0,113,227,0.18);
}

/* 登录按钮 */
.btn {
  width:100%; margin-top:8px;
  padding:15px;
  background: var(--apple-blue);
  border:none; border-radius:980px;
  color:#fff; font-size:15px; font-weight:600; font-family:inherit;
  cursor:pointer; position:relative; overflow:hidden;
  box-shadow: 0 4px 18px rgba(0,113,227,0.38);
  transition: transform .15s, box-shadow .15s, background .15s;
}
.btn::after {
  content:''; position:absolute; inset:0;
  background: linear-gradient(135deg,rgba(255,255,255,0.18) 0%,transparent 55%);
  opacity:0; transition:opacity .2s;
}
.btn:hover  { background:#0077ed; transform:translateY(-2px); box-shadow:0 8px 28px rgba(0,113,227,0.42); }
.btn:hover::after { opacity:1; }
.btn:active { transform:translateY(0); box-shadow:0 3px 12px rgba(0,113,227,0.3); }
</style>
</head>
<body>
<div class="card">
  <div class="island">
    <div class="island-dot"></div>
    <span class="island-label">JSP 聊天室</span>
  </div>

  <form method="post" action="checkuser.jsp" onsubmit="return chk()">
    <label class="field-label">用户名</label>
    <input type="text"     name="loginname" class="field" placeholder="请输入用户名" autocomplete="username">
    <label class="field-label">密码</label>
    <input type="password" name="password"  class="field" placeholder="请输入密码"   autocomplete="current-password">
    <button type="submit" class="btn">进入聊天室</button>
  </form>
</div>

<script>
function chk() {
  var n = document.querySelector('[name=loginname]').value.trim();
  var p = document.querySelector('[name=password]').value;
  if (!n || !p) { alert('请输入用户名与密码！'); return false; }
  return true;
}
</script>
</body>
</html>
