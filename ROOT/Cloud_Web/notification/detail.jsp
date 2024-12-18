<%@ include file="/Cloud_Web/includes/sessionCheck.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="cloud.NotiDAO, cloud.DBConnection, cloud.Noti" %>


<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
    <link rel="stylesheet" href="/Cloud_Web/styles/community_styles.css"> <!-- CSS 파일 링크 -->
    <script>
        function confirmDelete() {
            return confirm("정말 삭제하시겠습니까? 삭제된 글은 복구할 수 없습니다.");
        }
    </script>
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
                if (request.getMethod().equalsIgnoreCase("POST")) {
                        request.setCharacterEncoding("UTF-8");
                        // 작성자이거나 관리자인 경우 삭제 처리
                        if (Boolean.TRUE.equals(session.getAttribute("isAdmin"))) {
                            notiDAO.deleteNoti(id);
                            response.sendRedirect("list.jsp");
                            return; // 리다이렉트 이후 추가 렌더링 방지
                        }
                    }
    %>
    <div class="noti-details">
            <h2 class="noti-title"><%= noti.getTitle() %></h2>
            <div class="noti-meta">
            <p><strong>작성자:</strong> <%= noti.getUser() %></p>
            <p><strong>작성일:</strong> <%= noti.getCreatedAt() %></p>
            </div>
            <hr>
            <div class="noti-content">
            <pre><%= noti.getContent() %></pre>
            <% if (noti.getImagePath() != null && !noti.getImagePath().isEmpty()) { %>
            <p>
                <img src="<%= noti.getImagePath() %>" alt="Uploaded Image" style="max-width: 100%;">
            </p>
            <% } %>           
            </div>
            <button onclick="history.back()">뒤로가기</button>
            <%
                // 작성자이거나 관리자일 경우 삭제 버튼 표시
                if (Boolean.TRUE.equals(session.getAttribute("isAdmin"))) {
            %>
            <form method="post" onsubmit="return confirmDelete();">
                <button type="submit" class="button_delete">글 삭제</button>
            </form>
            <% } %>
    </div>
    <% } else { %>
            <p>해당 공지사항을 찾을 수 없습니다.</p>
    <%
        }}
    %>  

    
    </main>
</body>
</html>
