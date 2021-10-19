<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
    String id = (String) session.getAttribute("user_UID");
    String nickname = (String) session.getAttribute("user_name");
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

    try {

        String strSQL = "SELECT * FROM doc_table WHERE doc_UID = ?";
        pstmt = conn.prepareStatement(strSQL);
        pstmt.setInt(1, Integer.parseInt(num));

        rs = pstmt.executeQuery();
        rs.next();

        String title = rs.getString("doc_title");
        String contents = rs.getString("doc_main").trim();
        String category = rs.getString("doc_type");

%>

<html>
<HEAD>
    <TITLE> 글 수정 </TITLE>

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
            <a href="logout.jsp" class="head"><%=nickname%> 로그아웃</a><% }%>

        </div>
    </div>
</header>
<article id="main_con">
    <div id="write_con">
        <h1><b> 게시판 글쓰기 </b></h1>
        <form id="write_form" Name='Write' Action='modify_output.jsp?category=<%=category%>' Method='post'
              OnSubmit='return Check()'>
            <h3>제목</h3>
            <input type="hidden" name="num" value="<%=num%>">
            <input type='text' size='70' maxlength='50' name='title' value="<%=title%>" placeholder="제목을 입력해주세요">
            <br>
            <h3>내용</h3>
            <textarea cols='70' rows='15' wrap='virtual' name='contents'
                      placeholder="내용을 입력해주세요"><%=contents%></textarea>
            <br>
            <input id="form_submit" Type='Submit' Value='수정완료'>
        </form>
    </div>
</article>

<%
        } catch (SQLException e) {
            out.print("SQL에러 " + e.toString());
        } catch (Exception ex) {
            out.print("JSP에러 " + ex.toString());
        } finally {
            rs.close();
            pstmt.close();
            conn.close();
        }
    }

%>

</BODY>
</HTML>


