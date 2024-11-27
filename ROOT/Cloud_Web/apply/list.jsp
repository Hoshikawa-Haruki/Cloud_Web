<%@ include file="/Cloud_Web/includes/sessionAdminCheck.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="cloud.Apply, cloud.DBConnection, cloud.ApplyDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<% // DB 연결 및 DAO 생성 
    ApplyDAO applyDAO = new ApplyDAO(DBConnection.getConnection()); 
      // 페이지 정보 가져오기
    int pageSize = 10; // 페이지당 게시글 수
    int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1; // 현재 페이지
    List<Apply> applies = applyDAO.getApplies(currentPage, pageSize);
    int totalApply = applyDAO.getTotalApplies(); // 총 게시글 수
    int totalPages = (int) Math.ceil((double) totalApply / pageSize); // 총 페이지 수
    
%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>신청서 목록</title>
    <link rel="stylesheet" href="/Cloud_Web/styles/community_styles.css"> <!-- CSS 파일 링크 -->
    <script>
        function alreadyApply(event, isApply){
            console.log(isApply);
            if(isApply == 1){
                event.preventDefault();
                alert('이미 승인된 신청서입니다.');
            }
        }
    </script>
    
</head>

<body>
    <%@ include file="/Cloud_Web/default.jsp" %>
        <main>
            <article>
                <div>
                    <table>
                        <caption>커뮤니티 게시글 리스트</caption>
                        <colgroup>
                            <col style="width:5%">
                            <col>
                            <col style="width:10%">
                            <col style="width:10%">
                            <col style="width:5%">
                            <col style="width:20%">
                        </colgroup>

                        <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">이름</th>
                                <th scope="col">학번</th>
                                <th scope="col">ID</th>
                                <th scope="col">승인</th>
                                <th scope="col">작성일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (applies.size() == 0) {%>
                                <tr>
                                   <td colspan="4">아직 등록된 신청서가 없습니다.</td>
                                </tr>
                            <% } else { %>
                            <% for (Apply apply : applies) { %>
                                <tr>
                                    <td>
                                        <%= apply.getId() %>
                                    </td>
                                    <td>
                                        
                                        <a href="detail.jsp?id=<%= apply.getId() %>" onclick="alreadyApply(event,<%=apply.getIsApply()%>)">
                                            <%= apply.getName() %> 님의 신청서
                                        </a>
                                    </td>
                                    <td>
                                        <%= apply.getStudentNumber() %>
                                    </td>
                                    <td>
                                        <%= apply.getUserId() %>
                                    </td>
                                    <td>
                                        <% if (apply.getIsApply()==1 ) { %>
                                        O
                                        <% } else { %>
                                        X
                                        <% } %>
                                    </td>
                                    <td>
                                        <%= apply.getCreatedAt() %>
                                    </td>
                                </tr>
                                <% } } %>
                        </tbody>
                    </table>
                </div>
                <div class="bottom_elements">
                    <div class="bottom_paging_box">
                        <span>
                            <% if (currentPage > 1) { %>
                                <a href="?page=1">처음</a>
                            <% } %>
                        </span>
                        <span>
                            <% if (currentPage > 1) { %>
                                <a href="?page=<%= currentPage - 1 %>">이전</a>
                            <% } %>
                        </span>
                        <% for (int i = 1; i <= totalPages; i++) { %>
                            <% if (i == currentPage) { %>
                            <em>
                                <a><%= i %></a>
                            </em>
                            <% } else { %>
                                <a href="?page=<%= i %>"><%= i %></a>
                            <% } %>
                        <% } %>
                        <span>
                            <% if (currentPage < totalPages) { %>
                                <a href="?page=<%= currentPage + 1 %>">다음</a>
                            <% } %>
                        </span>
                        <span>
                            <% if (currentPage < totalPages) { %>
                                <a href="?page=<%= totalPages %>">끝</a>
                            <% } %>
                        </span>
                    </div>
                </div>
            </article>
        </main>
        
</body>

</html>