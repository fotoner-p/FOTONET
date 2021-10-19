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

    String pageNum = request.getParameter("pageNum");
    String category = "0";
    if (pageNum == null) {
        pageNum = "1";
    }

    final int listSize = 11;
    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * listSize + 1;
    int endRow = currentPage * listSize;
    int lastRow = 0;
    int i = 0;
    int num[] = {0};
    int count = 0;
    Class.forName("com.mysql.jdbc.Driver");

    String url = "jdbc:mysql://localhost:3306/web_term?useUnicode=true&characterEncoding=UTF-8";
    Connection conn = DriverManager.getConnection(url, "Member", "apple");

    Statement stmt = conn.createStatement();
    String strSQL = "";

    if(category.equals("0"))
        strSQL = "SELECT * FROM doc_table";
    else{
        strSQL = "SELECT  * FROM doc_table WHERE doc_type = " + category;
    }
    ResultSet rs = stmt.executeQuery(strSQL);
    ResultSet rs1 = null;

    while (rs.next()) {
        count++;
    }
    lastRow = count;
%>

<html>
<head>
    <title> FOTONET </title>
    <link rel="stylesheet" href="//cdn.rawgit.com/hiun/NanumSquare/master/nanumsquare.css">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="./res/normal_form.css"/>
</head>

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
    <h1 style="font-size:60px; text-align: center; color: #7e6ca8">FOTONET</h1>
    <form method="get" action="search.jsp" class="search_bar">
			<span class='search_window'>
                <input type="hidden" name="category" value="<%=category%>">
				<input type='text' name="search_text" class='input_text'>
			</span>
        <button type='submit' class='sch_smit'>검색</button>
    </form>
    <ol class="table_contents">

        <hr class="gap">
        <%
            if (lastRow > 0) {
                if(category.equals("0")) {
                    strSQL = "SELECT * FROM doc_table ORDER BY doc_count DESC";
                    rs = stmt.executeQuery(strSQL);
                    for(i = 0 ; i < listSize * (currentPage - 1); i++)
                        rs.next();
                }
                else {
                    strSQL = "SELECT * FROM doc_table WHERE doc_type = " + category + " ORDER BY doc_count DESC";
                    rs = stmt.executeQuery(strSQL);

                    for(i = 0 ; i < listSize * (currentPage - 1); i++)
                        rs.next();
                }

                for (i = 0; i < listSize; i++) {
                    if (rs.next()) {
                        String listnum = Integer.toString(rs.getInt("doc_UID"));
                        int user_UID = rs.getInt("user_UID");
                        strSQL = "SELECT * FROM user_table WHERE user_UID = " + user_UID;
                        PreparedStatement pstmt = conn.prepareStatement(strSQL);

                        rs1 = pstmt.executeQuery(strSQL);
                        rs1.next();
                        int readcount = rs.getInt("doc_count");
                        int doc_type = rs.getInt("doc_type");
                        String title = rs.getString("doc_title");
                        String writedate = rs.getString("created");


        %>
        <a class="item_link" href="write_output.jsp?num=<%=listnum %>">
            <li class="table_item">
                <div class="item_link">
                    <div class="item_title">
                        <span class="doc_type"><%
                            switch (doc_type) {
                                case 1: %>IT<% break;
                            case 2: %>게임<% break;
                            case 3: %>유머<% break;
                            case 4: %>기타<% break;
                        }
                        %></span>
                        <%=title %>
                    </div>
                </div>
                <div class="item_side">
                    <span class="item_user vcol"><%=rs1.getString("user_name")%></span>
                    <span class="item_time vcol"><%=writedate%></span>
                    <span class="item_count vcol"> | 조회 <%=readcount %></span>
                </div>
            </li>
        </a>
        <hr class="gap">
        <%
                }
            }
        %>
    </ol>
    <% if (session_flag) { %>
    <div class="write_div">
        <div class="write">
            <a href='write.jsp?category=<%=category%>'>등록</a>
        </div>
    </div>
    <%}%>
    <div class="page_indicate">
        <%
                rs.close();
                stmt.close();
                conn.close();
            }

            if (lastRow > 0) {
                int setPage = 1;
                int lastPage = 0;
                if (lastRow % listSize == 0)
                    lastPage = lastRow / listSize;
                else
                    lastPage = lastRow / listSize + 1;

                if (currentPage > 1) {
        %>
        <a href="index.jsp?pageNum=<%=currentPage-1%>&category=<%=category%>">[이전]</a>
        <%
            }
            while (setPage <= lastPage) {
        %>
        <a href="index.jsp?pageNum=<%=setPage%>&category=<%=category%>">[<%=setPage%>]</a>
        <%
                setPage = setPage + 1;
            }
            if (lastPage > currentPage) {
        %>
        <a href="index.jsp?pageNum=<%=currentPage+1%>&category=<%=category%>">[다음]</a>
        <%
                }
            }
        %>
    </div>
</article>
</body>
</html>
