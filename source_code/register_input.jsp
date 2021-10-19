<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
    String email = request.getParameter("email");
    String nickname = request.getParameter("nickname");
    String psw = request.getParameter("psw");
    String repsw = request.getParameter("repsw");

    if(!psw.equals(repsw)){
        response.sendRedirect("./register.jsp?back=3");
    }
    else {
        Class.forName("com.mysql.jdbc.Driver");

        String url = "jdbc:mysql://localhost:3306/web_term?useUnicode=true&characterEncoding=UTF-8";
        Connection conn = DriverManager.getConnection(url, "Member", "apple");

        PreparedStatement pstmt1 = null;
        PreparedStatement pstmt2 = null;
        ResultSet rs = null;

        String strSQL = "SELECT email FROM user_table WHERE email = ?";
        pstmt1 = conn.prepareStatement(strSQL);
        pstmt1.setString(1, email);

        rs = pstmt1.executeQuery();
        if (rs.next()) {
            response.sendRedirect("./register.jsp?back=1");

            rs.close();
            pstmt1.close();
            conn.close();

            return;
        }

        strSQL = "SELECT user_name FROM user_table WHERE user_name = ?";
        pstmt1 = conn.prepareStatement(strSQL);
        pstmt1.setString(1, nickname);
        rs = pstmt1.executeQuery();
        if (rs.next()) {
            response.sendRedirect("./register.jsp?back=2");

            rs.close();
            pstmt1.close();
            conn.close();
        } else {
            Calendar dateIn = Calendar.getInstance();
            String indate = Integer.toString(dateIn.get(Calendar.YEAR)) + "-";
            indate = indate + Integer.toString(dateIn.get(Calendar.MONTH) + 1) + "-";
            indate = indate + Integer.toString(dateIn.get(Calendar.DATE)) + " ";
            indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY)) + ":";
            indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE)) + ":";
            indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));

            strSQL = "INSERT INTO user_table(email, user_name, user_pw, created) VALUES (?,?,?,?);";
            pstmt2 = conn.prepareStatement(strSQL);
            pstmt2.setString(1, email);
            pstmt2.setString(2, nickname);
            pstmt2.setString(3, psw);
            pstmt2.setString(4, indate);

            pstmt2.executeUpdate();

            rs.close();
            pstmt1.close();
            pstmt2.close();
            conn.close();

            response.sendRedirect("./login.jsp");
        }
    }
%>
