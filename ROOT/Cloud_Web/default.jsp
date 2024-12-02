<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="cloud.ApplyDAO, cloud.Apply, cloud.DBConnection" %>

<%
Boolean isMember = null;
%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>웹개발 홈페이지</title>
    <link rel="stylesheet" href="/Cloud_Web/styles/nav4_styles.css">

</head>

<body>
    <header>
        <div class="header-container">
            <div id="logo">
                <a href="/Cloud_Web/index.jsp"><img src="/Cloud_Web/images/logo3.png" alt="로고"></a>
            </div>
            <div id="auth">
            <% 
            if (session != null && session.getAttribute("userId") != null) { 
                String userName = (String) session.getAttribute("userName");
                isMember = (Boolean) session.getAttribute("isMember");
            %>
                안녕하세요,  <%= userName %> 님
                <a href="/Cloud_Web/login/logout.jsp" id="logout">로그아웃</a>
            <%
            } else {
            %>
                <a href="/Cloud_Web/login/loginPage.jsp" id="login">로그인</a>
                <a href="/Cloud_Web/signup/signup.jsp" id="signup">회원가입</a>
            <% } %>
                
            </div>
        </div>
    </header>
                
    <script>
        function alreadyApply(event) {
            var isMember = "<%= isMember %>";
            if (isMember == "true") {
            alert("이미 가입이 완료되었습니다.");
            event.preventDefault();
            }
        }

        function checkMember(event){
            var isMember = "<%= isMember %>";
            if(isMember == "false"){
                alert("가입신청을 먼저 해주세요.");
                event.preventDefault();
            }
        }
    </script>     
 

    <nav id="nav1">
    
    
        <ul class="nav-menu">
            <li><a href="/Cloud_Web/introduce.jsp">동아리 소개</a></li>
            <% 
            if (session != null && Boolean.TRUE.equals(session.getAttribute("isAdmin"))) { 
            %>
                <li><a href="/Cloud_Web/apply/list.jsp">가입신청 관리</a></li>
            <% 
            } else { 
            %>  
                
                <li><a href="/Cloud_Web/apply/apply.jsp" onclick="alreadyApply(event)">가입신청</a></li>
            <% } %>
            <li><a href="/Cloud_Web/activity/list.jsp">활동내역</a></li>
            <li><a href="/Cloud_Web/notification/list.jsp">공지사항</a></li>
            <li><a href="/Cloud_Web/community/list.jsp" onclick="checkMember(event)">커뮤니티</a></li>
            <li><a href="http://223.130.154.161:8080/openai.html" onclick="checkMember(event)">OpenAI</a></li>
        </ul>
    </nav>
</body>

</html>
