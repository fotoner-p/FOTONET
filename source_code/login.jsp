<%--
  Created by IntelliJ IDEA.
  User: jaemu
  Date: 2019-06-04
  Time: 오전 2:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인</title>
    <link rel="stylesheet" href="//cdn.rawgit.com/hiun/NanumSquare/master/nanumsquare.css">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="./res/register.css"/>
</head>
<body>
<div id="main">
    <!-- Section one -->
    <section id="sect1">
        <a href="listboard.jsp">FOTONET </a>
    </section>

    <section id="sect2">
        <form class="login" method="POST" action="login_input.jsp">
            <div class="login_container">
                <input class="email" type="email" placeholder="이메일" name="uname" autocomplete="username" required=""
                       oninvalid="this.setCustomValidity('이메일을 입력하세요')" oninput="this.setCustomValidity('')">
                <input class="psw" type="password" placeholder="비밀번호" name="psw" autocomplete="current-password"
                       required="" oninvalid="this.setCustomValidity('비밀번호를 입력하세요')"
                       oninput="this.setCustomValidity('')">
                <button class="signupBtn" type="submit">로그인</button>
            </div>
        </form>
        </article>
    </section>
</div>
</body>
</html>
