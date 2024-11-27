<%@ include file="/Cloud_Web/includes/sessionCheck.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="cloud.Apply, cloud.DBConnection, cloud.ApplyDAO" %>

<%
    if (request.getMethod().equalsIgnoreCase("POST")) {

        request.setCharacterEncoding("UTF-8");

        // 입력 값 가져오기
        String name = request.getParameter("name");
        String studentId = request.getParameter("studentId");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String department = request.getParameter("department");
        String introduction = request.getParameter("introduction");
        String interest = request.getParameter("interest");
        

        // 새로운 Apply 객체 생성
        Apply apply = new Apply();
        apply.setName(name);
        apply.setStudentNumber(studentId);
        apply.setPhone(phone);
        apply.setEmail(email);
        apply.setDepartment(department);
        apply.setIntroduction(introduction);
        apply.setInterest(interest);

        //TODO : 로그인된 유저의 id 넣어주기 (userId);
        apply.setUserId(session.getAttribute("userId").toString());
    

        // DAO로 DB에 추가
        ApplyDAO applyDao = new ApplyDAO(DBConnection.getConnection());
        applyDao.createApply(apply);

    }
%>

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>웹개발 홈페이지</title>
        <link rel="stylesheet" href="/Cloud_Web/styles/apply_styles.css">
    </head>

    <body>
        <%@ include file="/Cloud_Web/default.jsp" %>



            <section class="request">

                <article class="inviteImg">
                    <h2>동아리 가입 신청서</h2>
                    <p>자신을 자유롭게 소개 해 보세요. 아무렇게나 말씀해도 좋아요.</p>
                    <img src="../images/invite.jpg" alt="가입신청" />
                </article>


                <article class="inviteMain">
                    <form class="applicationForm" method="post">

                        <table class="inviteTable">
                            <tr>
                                <td><label>이름</label></td>
                                <td><label>학번</label></td>

                            </tr>

                            <tr>
                                <td><input type="text" id="name" name="name" value="<%= session.getAttribute("userName")%>" readonly></td>
                                <td><input type="text" id="studentId" name="studentId" placeholder="20000000"></td>
                            </tr>

                            <tr>
                                <td><label>휴대전화</label></td>
                                <td><label>Email</label></td>

                            </tr>

                            <tr>
                                <td><input type="tel" id="phone" name="phone" value="<%=session.getAttribute("phone")%>" readonly></td>
                                <td><input type="email" id="email" name="email" value="<%=session.getAttribute("email")%>" readonly></td>
                            </tr>

                            <tr>
                                <td><label>학과명</label></td>
                            </tr>

                            <tr>
                                <td><input type="text" id="department" name="department" placeholder="컴퓨터소프트웨어공학과"></td>
                            </tr>

                            <tr>
                                <td><label>본인소개</label></td>
                            </tr>

                            <tr>
                                <td colspan="2"><textarea id="introduction" name="introduction"
                                        placeholder="간단한 본인 소개 부탁드립니다" cols="65" rows="5"></textarea></td>
                            </tr>

                            <tr>
                                <td><label>관심분야</label></td>
                            </tr>

                            <tr>
                                <td colspan="2"><textarea id="interest" name="interest"
                                        placeholder="관심있는 분야, 언어를 적어주세요" cols="65" rows="5"></textarea></td>
                            </tr>

                        </table>
                        <input type="submit" value="제출" class="submitBtn">
                    </form>

                </article>
                
            </section>


    </body>

    </html>