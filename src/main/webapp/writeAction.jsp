<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/>
<jsp:setProperty property="bbsTitle" name="bbs"/> <%-- -> write.jsp에서 받아온 글 제목을 자바빈 Bbs클래스의 변수 bbsTitle에 저장 --%>
<jsp:setProperty property="bbsContent" name="bbs"/> <%-- -> write.jsp에서 받아온 글 내용을 자바빈 Bbs클래스의 변수 bbsContent에 저장 --%>

<%--
- 주의사항
	1. 로그인 한 사람만 글을 작성할 수 있도록 한다.
	2. 글 제목과 글 내용중 누락된 사항이 있는지 체크한다. 
	3. 로그인을 했고 모든 내용이 정상 입력 되었을 경우 글쓰기 성공 알림창을 띄우고
	   게시판 메인페이지(bbs.jsp)로 이동시킨다.
--%>

<%
//현재 세션상태를 체크한다.
String userID = null;
//세션의 userID값이 null이 아니라면 = 이미 로그인을 했다면
if(session.getAttribute("userID") != null){
	//userID를 세션의 userID값으로 설정
	userID = (String)session.getAttribute("userID");
}

//로그인을 안한 사람은 로그인을 하도록 유도한다.
if(userID == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인 하지 않았습니다. 로그인 후 사용해주세요.')");
	script.println("location.href='login.jsp'");
	script.println("</script>");
}
//로그인 성공시
else{
	//입력하지 않은 부분이 있는지 체크
	if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력하지 않은 내용이 존재합니다. 다시 입력해주세요.')");
		script.println("history.back()");
		script.println("</script>");
	}
	//정상 입력 시 게시글 작성 로직 수행
	else{
		BbsDAO bbsDAO = new BbsDAO();
		int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
		
		//게시글 작성이 정상 실행된 경우
		if(result != -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('게시글 작성!')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		//데이터베이스 오류인 경우
		else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('게시글 작성에 실패했습니다. 다시 작성해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		}
	}
}

%>