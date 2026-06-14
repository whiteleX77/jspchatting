<%@ page import="java.util.*" contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>聊天室</title>
<style>
*, *::before, *::after { margin:0; padding:0; box-sizing:border-box; }

body {
  min-height: 100vh;
  background: #000;
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Display', system-ui, sans-serif;
  overflow: hidden;
}

/* 液态背景光晕 */
.blob {
  position: fixed;
  border-radius: 50%;
  filter: blur(100px);
  opacity: 0.22;
  pointer-events: none;
  animation: morphBlob var(--dur, 10s) ease-in-out infinite alternate;
}
.b1 { --dur:13s; width:560px; height:560px; background:#007AFF; top:-180px; left:-180px; }
.b2 { --dur:9s;  width:420px; height:420px; background:#BF5AF2; bottom:-120px; right:-120px; animation-delay:-4s; }
.b3 { --dur:16s; width:360px; height:360px; background:#30D158; top:55%; left:48%; animation-delay:-8s; }

@keyframes morphBlob {
  0%   { border-radius:60% 40% 30% 70%/60% 30% 70% 40%; transform:translate(0,0) scale(1); }
  40%  { border-radius:30% 60% 70% 40%/50% 60% 30% 60%; transform:translate(24px,-24px) scale(1.06); }
  100% { border-radius:50% 50% 30% 70%/40% 60% 60% 40%; transform:translate(-12px,18px) scale(0.97); }
}

/* 玻璃卡片 */
.card {
  position: relative;
  z-index: 10;
  width: 380px;
  padding: 44px 40px 48px;
  background: rgba(255,255,255,0.05);
  backdrop-filter: blur(60px) saturate(180%);
  -webkit-backdrop-filter: blur(60px) saturate(180%);
  border: 1px solid rgba(255,255,255,0.1);
  border-radius: 30px;
  box-shadow:
    0 0 0 1px rgba(255,255,255,0.04),
    0 40px 80px rgba(0,0,0,0.75),
    inset 0 1px 0 rgba(255,255,255,0.14);
  animation: cardIn .6s cubic-bezier(0.16,1,0.3,1) both;
}
@keyframes cardIn {
  from { opacity:0; transform:translateY(40px) scale(0.95); }
  to   { opacity:1; transform:translateY(0)    scale(1);    }
}

/* 灵动岛标题胶囊 */
.island {
  display: flex;
  align-items: center;
  gap: 8px;
  width: fit-content;
  margin: 0 auto 36px;
  padding: 10px 22px;
  background: #0d0d0d;
  border: 1px solid rgba(255,255,255,0.13);
  border-radius: 999px;
  box-shadow:
    0 0 0 1px rgba(255,255,255,0.04),
    0 6px 24px rgba(0,0,0,0.6),
    inset 0 1px 0 rgba(255,255,255,0.08);
  animation: islandGlow 3s ease-in-out infinite;
}
@keyframes islandGlow {
  0%,100% { box-shadow: 0 0 0 1px rgba(255,255,255,.04), 0 6px 24px rgba(0,0,0,.6), inset 0 1px 0 rgba(255,255,255,.08); }
  50%      { box-shadow: 0 0 0 1px rgba(255,255,255,.06), 0 6px 24px rgba(0,0,0,.6), inset 0 1px 0 rgba(255,255,255,.08), 0 0 28px rgba(0,122,255,.2); }
}

.dot {
  width: 8px; height: 8px;
  background: #30D158;
  border-radius: 50%;
  box-shadow: 0 0 8px #30D158;
  animation: blink 2s ease-in-out infinite;
}
@keyframes blink { 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:.45;transform:scale(.8)} }

.island-label {
  color: rgba(255,255,255,0.88);
  font-size: 13px;
  font-weight: 600;
  letter-spacing: .5px;
}

/* 表单 */
.field-label {
  display: block;
  color: rgba(255,255,255,0.38);
  font-size: 11px;
  font-weight: 700;
  letter-spacing: 1px;
  text-transform: uppercase;
  margin-bottom: 8px;
}

.field {
  width: 100%;
  padding: 14px 18px;
  background: rgba(255,255,255,0.07);
  border: 1.5px solid rgba(255,255,255,0.08);
  border-radius: 14px;
  color: #fff;
  font-size: 15px;
  font-family: inherit;
  outline: none;
  transition: border-color .22s, background .22s, box-shadow .22s;
  margin-bottom: 16px;
}
.field::placeholder { color: rgba(255,255,255,0.2); }
.field:focus {
  background: rgba(255,255,255,0.1);
  border-color: rgba(0,122,255,0.75);
  box-shadow: 0 0 0 3.5px rgba(0,122,255,0.16);
}

.btn {
  width: 100%;
  margin-top: 8px;
  padding: 15px;
  background: linear-gradient(135deg, #007AFF 0%, #5856D6 100%);
  border: none;
  border-radius: 14px;
  color: #fff;
  font-size: 15px;
  font-weight: 600;
  font-family: inherit;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: transform .15s, box-shadow .15s;
  box-shadow: 0 6px 24px rgba(0,122,255,0.42);
}
.btn::after {
  content: '';
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, rgba(255,255,255,0.16) 0%, transparent 55%);
  opacity: 0;
  transition: opacity .2s;
}
.btn:hover  { transform:translateY(-2px); box-shadow:0 10px 32px rgba(0,122,255,0.52); }
.btn:hover::after { opacity: 1; }
.btn:active { transform:translateY(0);   box-shadow:0 4px 16px rgba(0,122,255,0.38); }
</style>
</head>
<body>
<div class="blob b1"></div>
<div class="blob b2"></div>
<div class="blob b3"></div>

<div class="card">
  <div class="island">
    <div class="dot"></div>
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
