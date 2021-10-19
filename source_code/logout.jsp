<%--
  Created by IntelliJ IDEA.
  User: jaemu
  Date: 2019-06-04
  Time: 오전 5:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<% session.invalidate(); %>

<script>

    alert("로그아웃 되었습니다.");

    location.href="listboard.jsp";

</script>
