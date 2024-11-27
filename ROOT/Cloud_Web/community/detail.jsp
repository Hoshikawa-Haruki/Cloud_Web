<%@ include file="/Cloud_Web/includes/sessionCheck.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="cloud.PostDAO, cloud.DBConnection, cloud.Post" %>


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
        String postId = request.getParameter("id");
        if (postId != null) {
            int id = Integer.parseInt(postId);
            PostDAO postDAO=new PostDAO(DBConnection.getConnection()); 

            // getPostById 메서드 호출해서 게시글 가져오기
            Post post = postDAO.getPostById(id);
             
            if (post != null) {
    %>
    <div class="post-details">
            <h2 class="post-title"><%= post.getTitle() %></h2>
            <div class="post-meta">
            <p><strong>작성자:</strong> <%= post.getUser() %></p>
            <p><strong>작성일:</strong> <%= post.getCreatedAt() %></p>
            </div>
            <hr>
            <div class="post-content">
            <p><%= post.getContent() %></p>
             </div>
            <input type="button" class="back" value="뒤로가기" onclick="history.back()">
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
