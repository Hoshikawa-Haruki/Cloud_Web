<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="cloud.User, cloud.DBConnection, cloud.UserDAO" %>

<%  
    Boolean isMember2 = null;
    if(session!=null && session.getAttribute("userId")!=null){
        UserDAO userDAO = new UserDAO(DBConnection.getConnection());
        User user = userDAO.getUserByUserId(session.getAttribute("userId").toString());
        isMember2 = user.getMember();
    }
%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>코딩 동아리 소개</title>
    <link rel="stylesheet" href="/Cloud_Web/styles/introduce_styles.css">
    <script>
        function isMember(event){
            var isMember="<%=isMember2%>";
            if(isMember=="true"){
                alert("이미 가입이 완료되었습니다.");
                event.preventDefault();
            }
            else if(isMember==null){
                alert("로그인 후 이용해주세요.");
                event.preventDefault();
            }
        }
    </script>
</head>

<body>
    <%@ include file="/Cloud_Web/default.jsp" %>
    <main>
        <article>
            <h1>코딩 동아리 소개</h1>
            <p>우리 코딩 동아리는 다양한 프로그래밍 언어와 기술을 배우고, 프로젝트를 통해 실무 경험을 쌓는 공간입니다.</p>
            
            <h2>동아리 목표</h2>
            <ul class="intro-list">
                <li>프로그래밍 기술 향상</li>
                <li>팀 프로젝트 경험</li>
                <li>신기술 습득 및 공유</li>
            </ul>

            <h2>주요 활동</h2>
            <ul class="intro-list">
                <li>정기 세미나 및 워크숍</li>
                <li>프로젝트 개발 및 발표</li>
                <li>외부 해커톤 참가</li>
                <li>멘토링 프로그램 운영</li>
            </ul>

            <h2>가입 안내</h2>
            <p>코딩에 관심 있는 누구나 환영합니다! 아래 링크를 통해 가입 신청을 해주세요.</p>
            <a href="/Cloud_Web/apply/apply.jsp" class="apply-btn" onclick="isMember(event)">가입 신청하기</a>
        </article>
    </main>
</body>

</html>
