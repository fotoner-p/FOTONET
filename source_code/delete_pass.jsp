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

    String num = request.getParameter("num");
%>
<script>
    var answer = confirm("정말 글을 삭제하시겠습니까?")
    if (answer) {
        location.href = "delete_input.jsp?num=<%=num%>";
    } else {
        history.go(-1);
    }
</script>
<%}%>