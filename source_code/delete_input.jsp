<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
    String id = (String) session.getAttribute("user_UID");
    boolean session_flag = true;

    if (id == null || id.equals("")) {
%>
<script>
    history.go(-1);
</script>
<%
    } else {
        String num = request.getParameter("num");

        Class.forName("com.mysql.jdbc.Driver");


        String url = "jdbc:mysql://localhost:3306/web_term?useUnicode=true&characterEncoding=UTF-8";
        Connection conn = DriverManager.getConnection(url, "Member", "apple");

        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String strSQL = "SELECT user_UID FROM doc_table WHERE doc_UID = ?";
        pstmt = conn.prepareStatement(strSQL);
        pstmt.setInt(1, Integer.parseInt(num));

        rs = pstmt.executeQuery();
        rs.next();

        String user_UID = Integer.toString(rs.getInt("user_UID"));
        if (id.equals(user_UID)) {
            strSQL = "DELETE From doc_table WHERE doc_UID=?";
            pstmt = conn.prepareStatement(strSQL);
            pstmt.setInt(1, Integer.parseInt(num));
            pstmt.executeUpdate();
            response.sendRedirect("./listboard.jsp");
        } else {
            response.sendRedirect("./wreite_output.jsp?num=" + num);
        }

        rs.close();
        pstmt.close();
        conn.close();
    }
%>
