<%@ include file="/Cloud_Web/includes/sessionAdminCheck.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="cloud.ApplyDAO, cloud.DBConnection, cloud.Apply, cloud.UserDAO, cloud.User" %>
<%@ page import="java.sql.*"%>

<%
String applyId = request.getParameter("id");
ApplyDAO applyDAO = new ApplyDAO(DBConnection.getConnection());
UserDAO userDAO = new UserDAO(DBConnection.getConnection());
int id = Integer.parseInt(applyId);
Apply apply = applyDAO.getApplyById(id);
User user = userDAO.getUserByUserId(apply.getUserId());

if (request.getMethod().equalsIgnoreCase("POST")) {

    if(apply.getIsApply()==0 && user.getMember()==false){

        if(applyId != null) {
            applyDAO.updateisMember(id);
            applyDAO.updateisApply(id);
            out.println("<script> alert('승인되었습니다.'); location.href='/Cloud_Web/apply/list.jsp'; </script>");
        }

    }else{
        out.println("<script> alert('이미 가입된 회원입니다.'); location.href='/Cloud_Web/apply/list.jsp'; </script>");
    }

}
%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>커뮤니티</title>
    <link rel="stylesheet" href="/Cloud_Web/styles/community_styles.css"> <!-- CSS 파일 링크 -->
</head>
<body>
    <%@ include file="/Cloud_Web/default.jsp" %>
    <main>
    <%
        // 게시글 ID를 request 파라미터에서 가져옴
        if (applyId != null) {

            if (apply != null) {
    %>
    <div class="apply-details">
            <h2 class="apply-title"><%= apply.getName() %>님의 신청서</h2>
            <div class="apply-meta">
            <p><strong>이름:</strong> <%= apply.getName() %></p>
            <p><strong>학번:</strong> <%= apply.getStudentNumber() %></p>
            <p><strong>학과:</strong> <%= apply.getDepartment() %></p>
            <p><strong>작성일자:</strong> <%= apply.getCreatedAt() %></p>
            </div>
            <hr>
            <div class="apply-intro"> <h2> 자기소개 </h2>
            <p><%= apply.getIntroduction() %></p>
             </div>
             <div class="apply-interest"> <h2> 관심분야 </h2> 
            <p><%= apply.getInterest() %></p>
             </div>

            
           
            <form method="post">
                <div class="button_container">
                <button onclick="history.back()">뒤로가기</button>
                <input class="submit_btn" type="submit" value="승인" >
                </div>
            </form>
            
            
    </div>
    <% } else { %>
            <p>해당 게시글을 찾을 수 없습니다.</p>
    <%}    
        } else {
    %>
            <p>잘못된 요청입니다. 게시글 ID가 없습니다.</p>
    <%
        }
    %>

    
    </main>
</body>
</html>
