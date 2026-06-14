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
*, *::before, *::after { margin:0; padding:0; box-sizing:border-box; }

html, body {
  height: 100%;
  background: #080808;
  font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Text', system-ui, sans-serif;
  border-top: 1px solid rgba(255,255,255,0.07);
}

.bar {
  display: flex;
  flex-direction: column;
  gap: 10px;
  padding: 12px 18px 14px;
  height: 100%;
}

.user-tag {
  display: flex;
  align-items: center;
  gap: 6px;
  color: rgba(255,255,255,0.38);
  font-size: 12px;
}
.user-tag b { color: #4DA3FF; font-weight: 600; }

.input-row {
  display: flex;
  gap: 10px;
  align-items: flex-end;
  flex: 1;
}

textarea {
  flex: 1;
  padding: 11px 15px;
  background: rgba(255,255,255,0.07);
  border: 1.5px solid rgba(255,255,255,0.09);
  border-radius: 14px;
  color: rgba(255,255,255,0.9);
  font-size: 14px;
  font-family: inherit;
  resize: none;
  outline: none;
  height: 54px;
  transition: border-color .2s, box-shadow .2s, background .2s;
}
textarea::placeholder { color: rgba(255,255,255,0.2); }
textarea:focus {
  background: rgba(255,255,255,0.09);
  border-color: rgba(0,122,255,0.65);
  box-shadow: 0 0 0 3px rgba(0,122,255,0.13);
}

.btn-send {
  flex-shrink: 0;
  height: 44px;
  padding: 0 22px;
  background: linear-gradient(135deg, #007AFF, #5856D6);
  border: none;
  border-radius: 12px;
  color: #fff;
  font-size: 14px;
  font-weight: 600;
  font-family: inherit;
  cursor: pointer;
  transition: transform .14s, box-shadow .14s;
  box-shadow: 0 4px 16px rgba(0,122,255,0.38);
}
.btn-send:hover  { transform:translateY(-1px); box-shadow:0 6px 20px rgba(0,122,255,0.48); }
.btn-send:active { transform:translateY(0);    box-shadow:0 3px 10px rgba(0,122,255,0.3); }

.actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.hint { color: rgba(255,255,255,0.2); font-size: 11px; }

.btn-clear {
  background: rgba(255,255,255,0.06);
  border: 1px solid rgba(255,255,255,0.08);
  border-radius: 8px;
  padding: 5px 12px;
  color: rgba(255,255,255,0.4);
  font-size: 12px;
  font-family: inherit;
  cursor: pointer;
  transition: background .18s;
}
.btn-clear:hover { background: rgba(255,255,255,0.11); }

.btn-logout {
  background: rgba(255,59,48,0.08);
  border: 1px solid rgba(255,59,48,0.18);
  border-radius: 8px;
  padding: 5px 12px;
  color: rgba(255,80,70,0.75);
  font-size: 12px;
  font-family: inherit;
  cursor: pointer;
  transition: background .18s;
}
.btn-logout:hover { background: rgba(255,59,48,0.14); }
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
function lgot() {
  top.close();
}
document.addEventListener('keydown', function(e) {
  if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') chk();
});
</script>
</body>
</html>
