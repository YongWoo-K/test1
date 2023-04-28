<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<title>View<title>
</head>
<body>
<%
//bbsID의 기본값을 0으로 설정
int bbsID = 0;
/*
만약 파라미터로 넘어온 오브젝트타입'bbsID'가 존재한다면 int타입으로 캐스팅해주고
그 값을 bbsID변수에 저장한다.
*/
if(request.getParameter("bbsID") != null){
	bbsID = Integer.parseInt(request.getParameter("bbsID"));
}

//유효하지 않은 글이라면(bbsID == 0)
if(bbsID == 0){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('유효하지 않은 글입니다.')");
	script.println("location.href='bbs.jsp'");
	script.println("</script>");
}
//유효한 글이라면 구체적인 정보를 Bbs의 객체인 'bbs'에 담는다
Bbs bbs = new BbsDAO().getBbs(bbsID); //-> BbsDAO의 getBbs()에 bbsID를 넣은 값을 bbs객체에 저장
%>

<%@include file="include/header.jsp"%>

<div class="container">
   <div class="row">
      <div class="col-12">
      
      <table class="table">
      	<thead>
      		<tr>
      			<th colspan="2">
      				<h1>게시글 보기</h1>
      			</th>
      		</tr>
      	</thead>
      	
      	<tbody>
      		<tr>
      			<td>게시글 제목</td>
      			<td>
      			<%=bbs.getBbsTitle().replaceAll(" ", "&nbsp").replaceAll("<","&lt;").replaceAll(">","&gt").replaceAll("\n","<br>")%>
      			</td>
      			<%-- -> 제목에 특수문자가 들어왔을 경우를 대비 --%>
      		</tr>
      		<tr>
      			<td>작성자</td>
      			<td><%=bbs.getUserID()%></td>
      		</tr>
      		<tr>
      			<td>작성일</td>
      			<td>
					<%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시" + bbs.getBbsDate().substring(14, 16) + "분 " %>
				</td>
      		</tr>
      		<tr>
      			<td>내용</td>
      			<td>
      			<%= bbs.getBbsContent().replaceAll(" ", "&nbsp").replaceAll("<","&lt;").replaceAll(">","&gt").replaceAll("\n","<br>")%>

      			</td>
      			<%-- -> 내용에 특수문자가 들어왔을 경우를 대비 --%>
      		</tr>
      	</tbody>
      </table>
      
      <div class="d-flex justify-content-end mt-3 mb-3">
      	<div class="btn-group">
      		<a href="bbs.jsp" class="btn btn-primary">목록</a>
      		<%
      		//해당글의 작성자가 본인이라면 수정과 삭제가 가능하도록 기능 설정
      		if(userID != null && userID.equals(bbs.getUserID())){
      		%>
      		<a href="update.jsp?bbsID=<%=bbsID%>" class="btn btn-success">수정</a>
      		<a href="deleteAction.jsp?bbsID=<%=bbsID%>" onclick="return confirm('삭제하시겠습니까?')" class="btn btn-danger">삭제</a>
      		<%}%>
      	</div>
      </div>
      
      </div>
   </div>
</div>

<%@include file="include/footer.jsp"%>
</body>
</html>