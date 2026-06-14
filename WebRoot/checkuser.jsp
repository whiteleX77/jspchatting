<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="utf-8"%>
<jsp:useBean id="db" class="bean.Dbcon" scope="request"/>

<html>  
  <body>    	
<%  //登录数据库，进行用户验证 
	Connection con =db.getConnction();
	Statement stmt = con.createStatement();
	ResultSet rs = stmt.executeQuery("select * from user"+" where username = '" + request.getParameter("loginname") + "'");
	if(!rs.next())  //用户验证失败，提示重新登录
	{  
%>
		<b> <font size=5 color=red>
		很遗憾，数据库中没有“<%=request.getParameter("loginname")%>” 这个用户！<br><br>
        <a href=index.jsp>请重新登录！</a>
		</font></b>
<%
    }
	else  //用户验证成功
	{
%>
		<center><b><font size=5 color=blue>
		<%= rs.getString("name") %> 同学，祝贺你登录成功！<br>良好的开始是成功的一半.<br> </font><p>
		你的登录名是： <font size=4 color=blue> <%=request.getParameter("loginname")%><br></font>
		你的IP地址是： <font size=4 color=blue> <%= request.getRemoteAddr()%><br></font>
		</b></center>
<%
	if(session.getAttribute("name")!=null)session.removeAttribute("name");
	if(session.getAttribute("sex")!=null)session.removeAttribute("sex");
		session.setAttribute("name",rs.getString("name"));
		session.setAttribute("sex",rs.getString("sex"));	
	
	   String guestname=rs.getString("name");
	   String guestsex=rs.getString("sex");
		
		String opwin="login.jsp?name="+guestname+"&sex="+guestsex;
%>
	<script Language = javascript>
		function opwinfnc()
		{
	     window.open("<%=opwin%>","<%=guestname%>","<%=guestsex%>","toolbar=no,menubar=no,width=660,height=520");
	     self.close();		
		}
	</script>

<br><center><input type="button" name="chatbutton" value="进入聊天室" onclick="opwinfnc()"><br></center>

 <%
	} 		
	rs.close(); 
	stmt.close(); 
	con.close();
%>
  </body>
</html>
