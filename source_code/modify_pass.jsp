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


	response.sendRedirect("modify.jsp?num="+num);
}%>