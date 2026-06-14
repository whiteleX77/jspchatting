<%@ page contentType="text/html; charset=utf-8"%>
<%
  String guestnam = (String) session.getAttribute("nam0");
  if (guestnam == null) guestnam = "游客";
  String safeGuestnam = guestnam.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
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
  background: rgba(245,245,247,0.82);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-top: 1px solid rgba(0,0,0,0.07);
  -webkit-font-smoothing: antialiased;
}

.bar {
  display:flex; flex-direction:column; gap:10px;
  padding:14px 18px 16px; height:100%;
}
.user-tag { color:var(--text-sec); font-size:12px; font-weight:500; }
.user-tag b { color:var(--apple-blue); font-weight:700; }

.input-row { display:flex; gap:10px; align-items:flex-end; flex:1; }

textarea {
  flex:1; padding:12px 16px; height:52px;
  background: rgba(255,255,255,0.8);
  border: 1.5px solid rgba(0,0,0,0.09);
  border-radius: 14px;
  color:var(--text-main); font-size:14px; font-family:inherit;
  resize:none; outline:none;
  transition: border-color .2s, box-shadow .2s, background .2s;
  -webkit-appearance:none;
}
textarea::placeholder { color:rgba(0,0,0,0.22); }
textarea:focus {
  background:rgba(255,255,255,0.95);
  border-color:var(--apple-blue);
  box-shadow:0 0 0 3px rgba(0,113,227,0.15);
}

.btn-send {
  flex-shrink:0; height:42px; padding:0 22px;
  background: var(--apple-blue);
  border:none; border-radius:980px;
  color:#fff; font-size:14px; font-weight:600; font-family:inherit;
  cursor:pointer;
  box-shadow:0 3px 14px rgba(0,113,227,0.35);
  transition:transform .14s, box-shadow .14s, background .14s;
}
.btn-send:hover  { background:#0077ed; transform:translateY(-1px); box-shadow:0 6px 18px rgba(0,113,227,0.42); }
.btn-send:active { transform:none; background:#006cce; }

.actions { display:flex; justify-content:space-between; align-items:center; }
.hint    { color:rgba(0,0,0,0.22); font-size:11px; }

.btn-clear {
  padding:5px 14px;
  background:rgba(0,0,0,0.06); border:none; border-radius:980px;
  color:var(--text-sec); font-size:12px; font-weight:500; font-family:inherit;
  cursor:pointer; transition:background .18s;
}
.btn-clear:hover { background:rgba(0,0,0,0.11); }

.btn-logout {
  padding:5px 14px;
  background:rgba(255,59,48,0.1); border:none; border-radius:980px;
  color:#c02a22; font-size:12px; font-weight:600; font-family:inherit;
  cursor:pointer; transition:background .18s;
}
.btn-logout:hover { background:rgba(255,59,48,0.18); }
</style>
</head>
<body>
<div class="bar">
  <div class="user-tag">以 <b><%= safeGuestnam %></b> 身份发言</div>

  <form name="frm1" action="talking.jsp" method="post" target="fram0">
    <div class="input-row">
      <textarea name="txttalk" placeholder="输入消息，Ctrl+Enter 发送…"></textarea>
      <button type="button" class="btn-send" onclick="chk()">发送</button>
    </div>
  </form>

  <div class="actions">
    <span class="hint">Ctrl + Enter 快速发送</span>
    <div style="display:flex;gap:8px;">
      <button class="btn-clear" onclick="document.frm1.txttalk.value=''">清除</button>
      <form action="logout.jsp" method="post" name="frm2" style="display:inline">
        <button type="submit" class="btn-logout" onclick="lgot()">退出聊天</button>
      </form>
    </div>
  </div>
</div>

<script>
function chk() {
  var ta = document.frm1.txttalk;
  if (!ta.value.trim()) return;
  document.frm1.submit();
  ta.value = '';
}
function lgot() { top.close(); }
document.addEventListener('keydown', function(e) {
  if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') chk();
});
</script>
</body>
</html>
