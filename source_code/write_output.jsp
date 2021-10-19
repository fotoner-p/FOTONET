<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
    String id = (String) session.getAttribute("user_UID");
    String nickname = (String) session.getAttribute("user_name");
    boolean session_flag = true;
    if (id == null || id.equals("")) {
        session_flag = false;
    }

    String num = request.getParameter("num");

    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/web_term?useUnicode=true&characterEncoding=UTF-8";
    Connection conn = DriverManager.getConnection(url, "Member", "apple");

    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSet rs1 = null;
    String strSQL = "";
    try {
        strSQL = "SELECT * FROM doc_table WHERE doc_UID = ?";
        pstmt = conn.prepareStatement(strSQL);
        pstmt.setInt(1, Integer.parseInt(num));

        rs = pstmt.executeQuery();
        rs.next();

        String title = rs.getString("doc_title");
        String contents = rs.getString("doc_main").trim();
        String writedate = rs.getString("created");
        String doc_type = Integer.toString(rs.getInt("doc_type"));
        int readcount = rs.getInt("doc_count");

        int user_UID = rs.getInt("user_UID");
        strSQL = "SELECT * FROM user_table WHERE user_UID = " + user_UID;
        pstmt = conn.prepareStatement(strSQL);
        rs = pstmt.executeQuery(strSQL);
        rs.next();
        String name = rs.getString("user_name");
%>
<html>
<head>
    <title> 게시판 </title>
    <link rel="stylesheet" href="//cdn.rawgit.com/hiun/NanumSquare/master/nanumsquare.css">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="./res/normal_form.css"/>
</head>

<body>
<header class="core">
    <div class="header_container">
        <a href="listboard.jsp?category=0" class="head <% if(doc_type.equals("0")) { %>cur_head <% }%>">전체글</a>
        <a href="listboard.jsp?category=1" class="head <% if(doc_type.equals("1")) { %>cur_head <% }%>">IT</a>
        <a href="listboard.jsp?category=2" class="head <% if(doc_type.equals("2")) { %>cur_head <% }%>">게임</a>
        <a href="listboard.jsp?category=3" class="head <% if(doc_type.equals("3")) { %>cur_head <% }%>">유머</a>
        <a href="listboard.jsp?category=4" class="head <% if(doc_type.equals("4")) { %>cur_head <% }%>">기타</a>
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
        <h1><%=title %>
        </h1>
        <TABLE>
            <TR>
                <TD align='left'> 작성자 : <%=name %>
                </TD>
                <TD align=right>작성일: <%=writedate %>, 조회수: <%=readcount %>
                </TD>
            </TR>
        </TABLE>
        <hr class="gap">
        <TABLE>
            <TR>
                <TD>
                    <%=contents %>
                </TD>
            </TR>
        </TABLE>
        <hr class="gap">
        <%
            if (session_flag) {
                if (id.equals(Integer.toString(user_UID))) {
        %>
        <TABLE>
            <TR>
                <TD align='left'>
                    <a href="./modify_pass.jsp?num=<%=num %>">[수정하기]</a>
                    <a href="./delete_pass.jsp?num=<%=num %>">[삭제하기]</a>
                </TD>
            </TR>
        </TABLE>
        <%
                }
            }
        %>

        <%
                strSQL = "UPDATE doc_table SET doc_count=doc_count+1 WHERE doc_UID = ?";
                pstmt = conn.prepareStatement(strSQL);
                pstmt.setInt(1, Integer.parseInt(num));
                pstmt.executeUpdate();

            } catch (SQLException e) {
                out.print("SQL에러 " + e.toString());
            } catch (Exception ex) {
                out.print("JSP에러 " + ex.toString());
            }
        %>

        <%
            if (session_flag) {
        %>
        </TABLE>
        <form method="POST" action="comment.jsp" class="search_bar">
			<span class='search_window'>
				<input type='text' name="comment_text" class='input_text' >
				<input type='hidden' name="doc_id" value="<%=num%>">
			</span>
            <button type='submit' class='sch_smit'>댓글달기</button>
        </form>
        <%
            }
        %>

        <h3 style="margin-left:15px; margin-bottom: 5px">댓글</h3>
        <ol class="table_contents">
            <hr class="gap">
            <%
                strSQL = "SELECT * FROM comment_table WHERE doc_UID = ?";
                pstmt = conn.prepareStatement(strSQL);
                pstmt.setInt(1, Integer.parseInt(num));
                rs = pstmt.executeQuery();


                while(rs.next()){
                    strSQL = "select user_name FROM user_table WHERE user_UID = ?";
                    pstmt = conn.prepareStatement(strSQL);
                    pstmt.setInt(1, rs.getInt("user_UID"));

                    rs1 = pstmt.executeQuery();
                    rs1.next();
            %>
            <li class="table_item">

                <div class="item_side">
                    <span class="item_user vcol"><%=rs1.getString("user_name")%></span>
                    <span class="item_time vcol"><%=rs.getString("created")%></span>
                </div>
                <div class="item_link">
                    <div class="item_title"><%=rs.getString("comment_main")%></div>
                </div>
            </li>
            <hr class="gap">
            <%
                }
            %>
        </ol>
    </div>
</article>
</BODY>
</HTML>
