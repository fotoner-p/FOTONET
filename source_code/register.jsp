<%--
  Created by IntelliJ IDEA.
  User: jaemu
  Date: 2019-06-04
  Time: 오전 2:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String back = request.getParameter("back");
    int error = 0;
    boolean session_flag = true;
    if (back != null) {
        error = Integer.parseInt(back);
    }
%>
<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="//cdn.rawgit.com/hiun/NanumSquare/master/nanumsquare.css">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="./res/register.css"/>
</head>
<body>
<section id="sect1"><a href="listboard.jsp">FOTONET </a></section>
<section id="sect2">
    <form class="login" method="POST" action="register_input.jsp">
        <div class="login_container">
            <!--<label for="uname"><b>Username</b></label>-->

            <%
                if(error == 1) {
                %><h3 id = "error">이미 존재하는 이메일 입니다.</h3 ><%
                } else if (error == 2){
                %><h3 id = "error">이미 존재하는 닉네임 입니다.</h3 ><%
                } else if (error == 3){
                %><h3 id = "error">비밀번호가 서로 맞지 않습니다.</h3 ><%
                }
            %>

            <input class="email" type="email" placeholder="이메일" name="email" autocomplete="username" required=""
                   oninvalid="this.setCustomValidity('이메일을 입력하세요')" oninput="this.setCustomValidity('')">
            <input class="nickname" type="text" placeholder="닉네임" name="nickname" autocomplete="username" required=""
                   oninvalid="this.setCustomValidity('닉네임을 입력하세요')" oninput="this.setCustomValidity('')">
            <input class="psw" type="password" placeholder="비밀번호" name="psw" autocomplete="new-password" required=""
                   oninvalid="this.setCustomValidity('비밀번호를 입력하세요')" oninput="this.setCustomValidity('')">
            <input class="repsw" type="password" placeholder="비밀번호 확인" name="repsw" autocomplete="new-password"
                   required="" oninvalid="this.setCustomValidity('비밀번호를 입력하세요')" oninput="this.setCustomValidity('')">
            <button class="signupBtn" type="submit">회원가입</button>
        </div>
    </form>
</section>
</body>
</html>
