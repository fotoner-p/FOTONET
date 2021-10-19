<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
    String id = (String) session.getAttribute("user_UID");
    boolean session_flag = true;

    String category = request.getParameter("category");

    if (category == null || category.equals("0")) {
        category = "4";
    }

    if (id == null || id.equals("")) {
%>
<script>
    history.go(-1);
</script>
<%
} else {

    String title = request.getParameter("title");
    String contents = request.getParameter("contents");

    Class.forName("com.mysql.jdbc.Driver");

    String url = "jdbc:mysql://localhost:3306/web_term?useUnicode=true&characterEncoding=UTF-8";
    Connection conn = DriverManager.getConnection(url, "Member", "apple");

    PreparedStatement pstmt2 = null;


    Calendar dateIn = Calendar.getInstance();
    String indate = Integer.toString(dateIn.get(Calendar.YEAR)) + "-";
    indate = indate + Integer.toString(dateIn.get(Calendar.MONTH) + 1) + "-";
    indate = indate + Integer.toString(dateIn.get(Calendar.DATE)) + " ";
    indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY)) + ":";
    indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE)) + ":";
    indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));



    String strSQL = "INSERT INTO doc_table(user_UID, doc_title, doc_type, doc_main, created)";
    strSQL = strSQL + "VALUES (?, ?, ?, ?, ?)";
    pstmt2 = conn.prepareStatement(strSQL);
    pstmt2.setInt(1, Integer.parseInt(id));
    pstmt2.setString(2, title);
    pstmt2.setInt(3, Integer.parseInt(category));
    pstmt2.setString(4, contents);
    pstmt2.setString(5, indate);
    pstmt2.executeUpdate();
    pstmt2.close();
    conn.close();

    response.sendRedirect("./listboard.jsp");
}
%>
