<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="cloud.NotiDAO, cloud.DBConnection, cloud.Noti" %>


<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
    <link rel="stylesheet" href="/Cloud_Web/styles/community_styles.css"> <!-- CSS 파일 링크 -->
</head>
<body>
    <%@ include file="/Cloud_Web/default.jsp" %>
    <main>
    <%
        // 게시글 ID를 request 파라미터에서 가져옴
        String notiId = request.getParameter("id");
        if (notiId != null) {
            int id = Integer.parseInt(notiId);
            NotiDAO notiDAO = new NotiDAO(DBConnection.getConnection()); 

            // getNotiById 메서드 호출해서 게시글 가져오기
            Noti noti = notiDAO.getNotiById(id);
             
            if (noti != null) {
    %>
    <div class="noti-details">
            <h2 class="noti-title"><%= noti.getTitle() %></h2>
            <div class="noti-meta">
            <p><strong>작성자:</strong> <%= noti.getUser() %></p>
            <p><strong>작성일:</strong> <%= noti.getCreatedAt() %></p>
            </div>
            <hr>
            <div class="noti-content">
            <p><%= noti.getContent() %></p>
            <% if (noti.getImagePath() != null && !noti.getImagePath().isEmpty()) { %>
            <p>
                <img src="<%= noti.getImagePath() %>" alt="Uploaded Image" style="max-width: 100%;">
            </p>
            <% } %>           
            </div>
            <input type="button" class="back" value="뒤로가기" onclick="history.back()">
    </div>
    <% } else { %>
            <p>해당 공지사항을 찾을 수 없습니다.</p>
    <%}    
        } else {
    %>
            <p>잘못된 요청입니다. 공지사항 ID가 없습니다.</p>
    <%
        }
    %>

    
    </main>
</body>
</html>
