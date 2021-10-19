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
%>

<html>
<HEAD>
    <TITLE> 게시판 글쓰기 </TITLE>

    <SCRIPT language="JavaScript">
        function Check() {
            if (Write.title.value.length < 1) {
                alert("글제목을 입력하세요.");
                Write.write_title.focus();
                return false;
            }

            if (Write.contents.value.length < 1) {
                alert("글내용을 입력하세요.");
                Write.content.focus();
                return false;
            }

            return true;
        }

    </SCRIPT>
    <link rel="stylesheet" href="//cdn.rawgit.com/hiun/NanumSquare/master/nanumsquare.css">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="./res/normal_form.css"/>
</HEAD>

<body>

<body>
<header class="core">
    <div class="header_container">
        <a href="listboard.jsp?category=0" class="head <% if(category.equals("0")) { %>cur_head <% }%>">전체글</a>
        <a href="listboard.jsp?category=1" class="head <% if(category.equals("1")) { %>cur_head <% }%>">IT</a>
        <a href="listboard.jsp?category=2" class="head <% if(category.equals("2")) { %>cur_head <% }%>">게임</a>
        <a href="listboard.jsp?category=3" class="head <% if(category.equals("3")) { %>cur_head <% }%>">유머</a>
        <a href="listboard.jsp?category=4" class="head <% if(category.equals("4")) { %>cur_head <% }%>">기타</a>
    </div>
</header>


<header class="main_bar">
    <div class="header_container">
        <a href="index.jsp" class="head">FOTONET</a>
        <div class="session_logic">
            <% if (!session_flag) { %><a href="login.jsp" class="head">로그인</a>|<a href="register.jsp"
                                                                                  class="head">회원가입</a><% } else { %>
            <a href="logout.jsp" class="head">로그아웃</a><% }%>

        </div>
    </div>
</header>
<article id="main_con">
    <div id="write_con">
        <h1><b> 게시판 글쓰기 </b></h1>
        <form id="write_form" Name='Write' Action='write_input.jsp?category=<%=category%>' Method='post' OnSubmit='return Check()'>
            <h3>제목</h3>
            <input type='text' size='70' maxlength='50' name='title' placeholder="제목을 입력해주세요">
            <br>
            <h3>내용</h3>
            <textarea cols='70' rows='15' wrap='virtual' name='contents' placeholder="내용을 입력해주세요"></textarea>
            <br>
            <input id="form_submit" Type='Submit' Value='등록'>
        </form>
    </div>
</article>
</body>
</html>

<% } %>