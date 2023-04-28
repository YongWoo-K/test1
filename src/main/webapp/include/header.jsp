<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//현재 세션 상태를 체크
String userID = null;
//세션의 userID값이 null이 아니라면 = 이미 로그인을 했다면
if(session.getAttribute("userID") != null){
	//userID를 세션의 userID값으로 설정
	userID = (String)session.getAttribute("userID");
}

//pageNumber의 기본값을 1으로 설정
int pageNumber = 1;
/*
만약 파라미터로 넘어온 오브젝트타입'pageNumber'가 존재한다면 int타입으로 캐스팅해주고
그 값을 pageNumber변수에 저장한다.
*/
if(request.getParameter("pageNumber") != null){
	pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Header</title>
</head>
<body>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">

	<div class="container-fluid">
	
		<a class="navbar-brand active" href="main.jsp">
		Kim's bulletin board
		</a>
		
		<%-- 토글버튼 --%>
		<button 
		class="navbar-toggler" 
		type="button" 
		data-bs-toggle="collapse" 
		data-bs-target="#collapsibleNavbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		
		<div class="collapse navbar-collapse" id="collapsibleNavbar">
		
			 <ul class="navbar-nav me-auto">
			 	<li class="nav-item">
			 		<a class="nav-link" href="main.jsp">메인</a>
			 	</li>
			 	
			 	<li class="nav-item">
			 		<a class="nav-link" href="bbs.jsp">게시판</a>
			 	</li>
			 </ul>
			 <%
			 //로그인 하지않았을 경우 보여지는 화면
			 if(userID == null){
			 %>
			 <ul class="navbar-nav mr-auto">
			 
			 	<li class="nav-item dropdown">
			 	
			 		<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">회원관리</a>
			 		<ul class="dropdown-menu">
			 			<li>
			 				<a class="dropdown-item active" href="login.jsp">
			 				로그인
			 				</a>
			 			</li>
			 			
			 			<li>
			 				<a class="dropdown-item" href="join.jsp">
			 				회원가입
			 				</a>
			 			</li>
			 		</ul>
			 		
			 	</li>
			 	
			 </ul>
			 <%
			 //로그인이 되어있는 상태에서 보여지는 화면
			 } else{%>
			 <ul class="navbar-nav mr-auto">
			 
			 	<li class="nav-item dropdown">
			 	
			 		<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">회원관리</a>
			 		<ul class="dropdown-menu">
			 			<%-- 이미 로그인 되어있는 상태이므로 로그인메뉴를 보여줄 필요 없다.
			 			<li>
			 				<a class="dropdown-item active" href="login.jsp">
			 				로그인
			 				</a>
			 			</li>
			 			--%>
			 			<li>
			 				<a class="dropdown-item" href="logoutAction.jsp">
			 				로그아웃
			 				</a>
			 			</li>
			 		</ul>
			 		
			 	</li>
			 	
			 </ul>
			 <%} %>
		</div>
		
	</div>
	
</nav>

</body>
</html>