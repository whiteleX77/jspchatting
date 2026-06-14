<%@ page import="java.util.*" contentType="text/html; charset=utf-8"%>
<html>
 <Script Language=javascript>
   function fnc() {
	if (frm.loginname.value == "" || frm.password.value == "") {
		window.alert("请输入用户名与密码！");
		document.frm.elements(0).focus();
		return;
	  }
	 frm.submit();
	}
 </Script>
 <head><title>登录</title></head>
 <body>
	<center><font size=4 color=red><b>聊天室登录</b></font></center><hr>
	<center>
    <form name=frm method=post action=checkuser.jsp>
	  <font color=darkgreen size=4><b>用户名：</b>	</font>
		<input type="text" name="loginname" size=25><br><br>
	  <font color=darkgreen size=4><b>密 码：</b></font>
		<input type="password" name="password" size=25><br><br>
		<input type=button value='登录' onclick="fnc()">
	</form>
	</center>
 </body>
</html>
