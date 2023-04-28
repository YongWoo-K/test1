<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%request.setCharacterEncoding("UTF-8");%>

<%
//현재 세션상태를 체크한다.
String userID = null;
//세션의 userID값이 null이 아니라면 = 이미 로그인을 했다면
if(session.getAttribute("userID") != null){
	//userID를 세션의 userID값으로 설정
	userID = (String)session.getAttribute("userID");
}

//로그인 한 사용자만 게시글을 작성할 수 있도록 한다.
//로그인을 안한 사람은 로그인을 하도록 유도한다.
if(userID == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인 하지 않았습니다. 로그인 후 사용해주세요.')");
	script.println("location.href='login.jsp'");
	script.println("</script>");
}

//현재 게시글 번호 체크
int bbsID = 0;
if(request.getParameter("bbsID") != null){
	bbsID = Integer.parseInt(request.getParameter("bbsID"));
}
//게시글 번호가 0 -> 유효하지 않은 글
if(bbsID == 0){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('유효하지 않은 글입니다.')");
	script.println("location.href='bbs.jsp'");
	script.println("</script>");
}

//해당 'bbsID'에 대한 게시글을 가져온 후 다음 세션을 통해 작성자 본인이 맞는지 체크
Bbs bbs = new BbsDAO().getBbs(bbsID);
//게시글 작성자와 게시글 수정자가 동일인물이 아닐경우
if(!userID.equals(bbs.getUserID())){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('권한이 없습니다.')");
	script.println("location.href='bbs.jsp'");
	script.println("</script>");
}
else{
	//입력 내용 중 누락된 부분있는지 체크
	if(request.getParameter("bbsTitle") == null ||
	request.getParameter("bbsContent") == null ||
	request.getParameter("bbsTitle").equals("") ||
	request.getParameter("bbsContent").equals("")){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력하지 않은 내용이 존재합니다. 다시 입력해주세요.')");
		script.println("history.back()");
		script.println("</script>");
	}
	//정상입력 -> 글 수정 로직 수행
	else{
		BbsDAO bbsDAO = new BbsDAO();
		int result = bbsDAO.update(bbsID,request.getParameter("bbsTitle"),request.getParameter("bbsContent"));
		//데이터베이스 오류인 경우(대부분 dbID 혹은 dbPassword가 틀린 것)
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 수정에 실패했습니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		//글 수정이 정상적으로 실행
		else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 수정 성공!')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
	}
	
}
%>