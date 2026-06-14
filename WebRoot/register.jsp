<%@ page contentType="text/html; charset=utf-8" import="java.sql.*,bean.Dbcon"%>
<%
  String name     = request.getParameter("name");
  String password = request.getParameter("password");
  String confirm  = request.getParameter("confirm");

  // 基础校验
  if (name == null || name.trim().isEmpty()
      || password == null || password.isEmpty()
      || confirm  == null || !confirm.equals(password)) {
    response.sendRedirect("index.jsp?error=invalid");
    return;
  }

  name = name.trim();

  // 长度校验（name varchar(15)，password varchar(10)）
  if (name.length() > 15 || password.length() > 10) {
    response.sendRedirect("index.jsp?error=toolong");
    return;
  }

  Connection con    = null;
  PreparedStatement pstmt = null;
  ResultSet rs      = null;

  try {
    con = Dbcon.getConnction();

    // 检查用户名是否已存在
    pstmt = con.prepareStatement("SELECT id FROM user WHERE name = ?");
    pstmt.setString(1, name);
    rs = pstmt.executeQuery();
    if (rs.next()) {
      response.sendRedirect("index.jsp?error=exists");
      return;
    }
    rs.close(); pstmt.close();

    // 插入新用户
    pstmt = con.prepareStatement("INSERT INTO user (name, password) VALUES (?, ?)");
    pstmt.setString(1, name);
    pstmt.setString(2, password);
    pstmt.executeUpdate();

    response.sendRedirect("index.jsp?success=1");

  } catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("index.jsp?error=db");
  } finally {
    try { if (rs    != null) rs.close();    } catch (Exception ignored) {}
    try { if (pstmt != null) pstmt.close(); } catch (Exception ignored) {}
    try { if (con   != null) con.close();   } catch (Exception ignored) {}
  }
%>
