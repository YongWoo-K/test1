<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<title>BBS - main</title>
</head>
<body>
<%@include file="include/header.jsp"%>

<div class="container">
	<div class="row">
		<div class="col-md-12">
		
		<h1 class="mt-3 mb-3">BBS</h1>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>
					번호
					</th>
					
					<th>
					제목
					</th>
					
					<th>
					작성자
					</th>
					
					<th>
					작성일
					</th>
				</tr>
			</thead>
			
			<tbody>
			<%
			//BbsDAO의 객체 생성
			BbsDAO bbsDAO = new BbsDAO();
			//객체의 getList(pageNumber)를 이용해 해당 페이지의 목록을 가져옴
			ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
			//가져온 목록을 for문으로 하나씩 출력 
			for(int i = 0; i < list.size(); i++){
			%>
				<%-- 실제 데이터를 사용자에게 보여주는 부분 --%>
				<tr>
				<%-- 현재 게시글에 대한 정보를 하나씩 데이터베이스에서 불러와서 보여줌 --%>
					<td><%=list.get(i).getBbsID()%></td> 
					<td>
						<a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>">
						<%=list.get(i).getBbsTitle()%>
						<%-- viewpage로 해당 게시글번호를 매개변수로 보내서 처리하도록 한다. 
						-> href="주소?변수명=값" 의 방식으로 처리--%>
						</a>
					</td>				
					<td><%=list.get(i).getUserID()%></td>
					<%-- 날짜데이터를 가져오는것은 substring()함수를 사용하여 db내부에서 필요한 정보만 잘라서 가져온다. --%>
					<td>
					<%=list.get(i).getBbsDate().substring(0,11) +
					list.get(i).getBbsDate().substring(11,13) + "시" +
					list.get(i).getBbsDate().substring(14,16) + "분"
					%>
					</td>
					
				</tr>
			<%}%>
			</tbody>
		</table>
		
		
		<div class="d-flex justify-content-center mt-5 mb-3">
			<%
			/*
			테이블 밑에 이전,다음 버튼을 구현 
			-> 페이지번호가 1이 아니라면(게시글이 11개 이상이라면) pageNumber에서 1을 뺴거나 더한 값을 넣어서
			   게시판 메인화면으로 이동하도록 한다.
			*/
			if(pageNumber != 1){
			%>
			<div class="btn-group">
				<a class="btn btn-success" href="bbs.jsp?pageNumber=<%=pageNumber-1%>">Prev</a>
				<%}
				//BbsDAO에서 만들었던 nextPage()를 이용해서 다음페이지가 존재할 경우 
				if(bbsDAO.nextPage(pageNumber+1)){
				%>
				<a class="btn btn-primary" href="bbs.jsp?pageNumber=<%=pageNumber+1%>">Next</a>
				<%}%>
			</div>		
		</div>	
		
		
		<div class="d-flex justify-content-end mt-2 mb-5">
			<a href="write.jsp" class="btn btn-primary btn-lg">글쓰기</a>
		</div>
		
		</div>
	</div>
</div>

<%@include file="include/footer.jsp"%>
</body>
</html>

<%-- 
관계형 데이터베이스(relational database) 
	- 테이블로 이루어져 있으며 키와 값의 관계를 나타낸다.
	- 데이터 종속성을 관계로 표현하는 것이 관계형 데이터베이스이다.
	
	- 데이터베이스 용어
		- 열(column)
			- 각각의 열은 유일한 이름을 가지고 있고 자신만의 타입을 가지고 있다.
			- 이러한 열을 필드(field) 또는 속성(attribute)이라고 부른다.
			
		- 행(row)
			- 관계된 데이터의 묶음
			- 한 테이블의 모든 행은 같은 수의 열을 가지고 있다.
			- 이러한 행을 튜플(tuple) 또는 레코드(record)라고 부른다.
			
		- 값(value)
			- 테이블은 각각의 행과 열에 대응하는 값을 가지고 있다.
			
		- 키(key)
			- 테이블에서 행의 식별자로 사용되는 열을 키(key) 또는 기본키(primary key)라고 한다.
			
		- 관계(relationship)
			- 테이블 간 관계는 관계를 맺는 테이블의 수에 따라 아래와 같이 나눌 수 있다.
				1. 일대일 관계(one-to-one) : a-b 매치
				2. 일대다 관계(one-to-many) : a-b,c,d,... 매치
				3. 다대다 관계(many-to-many) : a-c,d / c-b 매치
--%>