<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
String num = request.getParameter("num"); 
String pass = request.getParameter("pass"); 

Class.forName("com.mysql.jdbc.Driver");


String url = "jdbc:mysql://localhost:3306/dbMember?useUnicode=true&characterEncoding=UTF-8";
Connection conn = DriverManager.getConnection(url,"Member","apple");

PreparedStatement pstmt = null;
ResultSet rs = null;

String strSQL = "SELECT pass FROM tblboard WHERE num = ?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, Integer.parseInt(num));

rs = pstmt.executeQuery();
rs.next();

String goodpass = rs.getString("pass").trim();
if (pass.equals(goodpass)){
	response.sendRedirect("modify.jsp?num=" + num);
}else{
	response.sendRedirect("modify_pass.jsp?num=" + num);	
}

rs.close();
pstmt.close();
conn.close();
%>
