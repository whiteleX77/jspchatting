<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%
	//由于name和sex是附着在URL中通过get方式传过来的参数，因此须作编码转换，以免中文参数乱码 
	String reqname = request.getParameter("name");
	String reqsex = request.getParameter("sex");	
      String guestname=reqname;
      String guestsex=reqsex;
	session.setAttribute("nam0",reqname); 
	session.setAttribute("sex0",reqsex);
		
	int i = 0, talker = 0;  //talker用于计算聊天室人数的变量
	Object talk = null;
	Object visitnam = null;
	Object visitsex = null;
	//调整聊天室的人数：
	String talkerstr=(String)application.getAttribute("talker");//talker为聊天室人数，存于application
	if(talkerstr == null) 
	{   //如为第一位进入聊天室，则聊天室人数talker置1；
	    //同时，在application中设定可保存的聊天语句数sentence为50条，超出50条时则按先进先出规则替换。
		application.setAttribute("talker", "1");		
	    application.setAttribute("sentence", "50"); 
	}
	else
	{
		talker = Integer.parseInt(talkerstr); //否则，聊天室人数talker+1		
		application.setAttribute("talker", String.valueOf(talker+1));
	}
    //sentence是在application中设定的可保存的聊天语句数
	String sentencestr = (String) application.getAttribute("sentence");
	int sentence = Integer.parseInt(sentencestr);
	//为保存聊天语句准备空间
	if(talker == 0)  //如为第一位聊天者，则初始化发言记录的整个空间
	{
		for(i=1;i<=sentence;i++)application.setAttribute("talk"+i,"");
		for(i=1;i<=sentence;i++)application.setAttribute("visitnam"+i,"");
		for(i=1;i<=sentence;i++)application.setAttribute("visitsex"+i,"");
	}
	else  //如已有发言，则将所有发言记录数组向后挪一格，为本人挪出发言空间
	{
		for(i = sentence; i >= 2; i--)
		{
			  talk = application.getAttribute("talk"+(i - 1));	
			application.setAttribute("talk"+i, talk);
			  visitnam = application.getAttribute("visitnam"+(i - 1));	
			application.setAttribute("visitnam"+i, visitnam);
			  visitsex = application.getAttribute("visitsex"+(i - 1));	
			application.setAttribute("visitsex"+i, visitsex);
		}	
	}
	//聊天记录数组的首行，填入本人的姓名和性别
	application.setAttribute("visitnam1", guestname);
	application.setAttribute("visitsex1", guestsex);
	//构建欢迎词作为一条发言填入首行
	String tking = null;
	Date dat = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-DD HH:mm:ss");
	String tim=sdf.format(dat);		
	tking = "<tr><td bgcolor = yellow align=left>欢迎"+guestname+"光临!光临时间："+tim+"</td></tr>";      	
	application.setAttribute("talk1", tking);
	//客户端跳转到聊天显示页面	
	response.sendRedirect("frame.jsp"); 
%>
