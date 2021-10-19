<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
    String email = request.getParameter("uname");
    String psw = request.getParameter("psw");

    Class.forName("com.mysql.jdbc.Driver");

    String url = "jdbc:mysql://localhost:3306/web_term?useUnicode=true&characterEncoding=UTF-8";
    Connection conn = DriverManager.getConnection(url, "Member", "apple");

    PreparedStatement pstmt1 = null;
    ResultSet rs = null;

    String strSQL = "SELECT email, user_pw, user_UID, user_name FROM user_table WHERE email = ? and user_pw = ?";
    pstmt1 = conn.prepareStatement(strSQL);
    pstmt1.setString(1, email);
    pstmt1.setString(2, psw);

    rs = pstmt1.executeQuery();

    if (rs.next()) {
        session.setAttribute("user_UID", Integer.toString(rs.getInt("user_UID")));
        session.setAttribute("user_name", rs.getString("user_name"));
        response.sendRedirect("./index.jsp");
    } else {
%>

<script>
    alert("로그인 실패");
    history.go(-1);
</script>

<% }
    rs.close();
    pstmt1.close();
    conn.close();
%>
