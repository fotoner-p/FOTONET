<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="utf-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
int num  = Integer.parseInt(request.getParameter("num"));

String title = request.getParameter("title");
String contents = request.getParameter("contents");

Class.forName("com.mysql.jdbc.Driver");


String url = "jdbc:mysql://localhost:3306/web_term?useUnicode=true&characterEncoding=UTF-8";
Connection conn = DriverManager.getConnection(url,"Member","apple");

PreparedStatement pstmt = null;

pstmt = conn.prepareStatement("UPDATE doc_table SET doc_title=?, doc_main=? WHERE doc_UID=?");
pstmt.setString(1, title);
pstmt.setString(2, contents);
pstmt.setInt(3, num);

pstmt.executeUpdate();

pstmt.close();
conn.close();

response.sendRedirect("write_output.jsp?num="+num);
%>