<%@page import="user.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%><%-- -> 자바스크립트를 사용하기 위함 --%>
<%@ page import="user.UserDAO"%><%-- -> 만든 데이터엑세스 클래스를 사용하기 위함 --%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="user" class="user.User" scope="page"/><%-- -> 자바빈 파일의 user클래스를 사용하기 위함 --%>
<jsp:setProperty name="user" property="userID"/><%-- -> join.jsp에서 받아온 사용자id를 자바빈파일의 user클래스 변수 userID에 저장 --%>
<jsp:setProperty name="user" property="userPassword"/><%-- -> join.jsp에서 받아온 사용자pw를 자바빈파일의 user클래스 변수 userPassword에 저장 --%>
<jsp:setProperty name="user" property="userName"/><%-- -> join.jsp에서 받아온 사용자name을 자바빈파일의 user클래스 변수 userName에 저장  --%>
<jsp:setProperty name="user" property="userGender"/><%-- -> join.jsp에서 받아온 사용자gender를 자바빈파일의 user클래스 변수 userGender에 저장  --%>
<jsp:setProperty name="user" property="userEmail"/><%-- -> join.jsp에서 받아온 사용자email을 자바빈파일의 user클래스 변수 userEmail에 저장  --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<title>JoinAction</title>
</head>
<body>

<%
//현재 세션상태를 체크한다.
String userID = null;
//세션의 userID값이 null이 아니라면 = 이미 로그인을 했다면
if(session.getAttribute("userID") != null){
	//userID를 세션의 userID값으로 설정
	userID = (String)session.getAttribute("userID");
}
//이미 로그인을 한 경우 다시 로그인을 할 수 없게 한다.
if(userID != null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('이미 로그인 되어있습니다.')");
	script.println("location.href='main.jsp'");
	script.println("</script>");
}


//DB 테이블에 들어가는 DB 중 하나라도 누락될 경우
if(
user.getUserID() == null ||
user.getUserPassword() == null ||
user.getUserName() == null ||
user.getUserGender() == null ||
user.getUserEmail() == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('입력하지 않은 내용이 존재합니다. 다시 입력해주세요.')");
	script.println("history.back()");
	script.println("</script>");
}
else{
	UserDAO userDAO = new UserDAO();
	int result = userDAO.join(user);
	
	if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 존재하는 아이디입니다. 다른 아이디를 입력해주세요.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('회원가입 성공! 다시 로그인해주세요.')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}
}

%>
<%--
-> 	- 실제 사용자가 입력한 회원정보 중에서 데이터가 하나라도 누락된 것이 있으면 입력이 되지 않은 사항이 있다고
	  알림창을 띄워주고 다시 이전화면으로 돌아가는 로직을 추가한다.
	- 입력이 다 되었다고 하더라도 아이디가 중복되면 이전페이지로 돌아가도록 로직을 추가한다.
		-> 이미 존재하는 아이디를 입력했다면 정상적으로 입력되지 않아 -1이 리턴된다.
 --%>

</body>
</html>