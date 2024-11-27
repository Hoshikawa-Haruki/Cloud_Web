<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="cloud.UserDAO, cloud.DBConnection, cloud.User, cloud.ApplyDAO, cloud.Apply" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    if (request.getMethod().equalsIgnoreCase("POST"))  {
        String userIdInput = request.getParameter("id");
        String userPwInput = request.getParameter("passwd");

        if (userIdInput != null) {
            UserDAO userDAO = new UserDAO(DBConnection.getConnection());
            User user = userDAO.getUserByUserId(userIdInput);
            if(user != null) {

            String dbUserId = user.getUserId();
            String dbUserPw = user.getPassword();
            ApplyDAO applyDAO = new ApplyDAO(DBConnection.getConnection());
            int isApply = applyDAO.getisApply(dbUserId);

                if (userIdInput.equals(dbUserId) && userPwInput.equals(dbUserPw)) {
                    // 세션 생성
                    // HttpSession session = request.getSession();
                    session.setAttribute("userId", user.getUserId()); // 세션에 userId 저장
                    session.setAttribute("userName", user.getName()); // 세션에 사용자 이름 저장
                    session.setAttribute("userNickName", user.getNickname()); // 세션에 사용자 닉네임 저장
                    session.setAttribute("phone",user.getPhone()); // 세션에 사용자 전화번호 저장
                    session.setAttribute("email",user.getEmail()); // 세션에 사용자 이메일 저장
                    session.setAttribute("isMember", user.getMember()); // 세션에 사용자 닉네임 저장
                    session.setAttribute("isAdmin", user.getAdmin()); // 세션에 사용자 닉네임 저장
                    session.setAttribute("isApply", isApply); // 세션에 사용자 승인 여부 저장
                    
                    out.println("<script> alert('로그인 성공.'); location.href='/Cloud_Web/default.jsp'; </script>"); // 로그인 성공 시 default 화면으로 이동
                } else {
                    out.println("<script> alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
                }
            } else {
                out.println("<script>alert('아이디가 존재하지 않습니다.'); history.back();</script>");
            }
        }
    }
%>

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>로그인</title>
        <link rel="stylesheet" href="/Cloud_Web/styles/login_styles.css">
    </head>

    <%@ include file="/Cloud_Web/default.jsp" %>

        <body>
            <div class="wrapper">
                <div class="container">
                    <h3>로그인</h3>
                    <form method="post" id="login_form">
                        <div class="login_input">
                            <input type="text" name="id" value="" placeholder="ID" required/>
                            <input type="password" name="passwd" value=""placeholder="PASSWORD" required/>
                        </div>
                        <div class="submit_button">
                            <input type="submit" value="Login" />
                        </div>
                    </form>
                </div>
            </div>
        </body>
    </html>