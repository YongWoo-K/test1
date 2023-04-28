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
<title>Update<title>
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
//해당 'bbsID'에 대한 게시글을 가져온다음 다음 세션을 통해서 작성자 본인이 맞는지 체크한다
Bbs bbs = new BbsDAO().getBbs(bbsID); //-> BbsDAO의 getBbs()에 bbsID를 넣은 값을 bbs객체에 저장

%>

<%@include file="include/header.jsp"%>

<div class="container">
   <div class="row">
      <div class="col-12">
      
      	<form method="post" action="updateAction.jsp?bbsID=<%=bbsID%>">
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
		      				<input 
		      				type="text" 
		      				class="form-control" 
		      				placeholder="글 제목" 
		      				name="bbsTitle" 
		      				maxlength="50" 
		      				value="<%=bbs.getBbsTitle()%>">
		      			</td>
		      		</tr>
		
		      		<tr>
		      			<td>내용</td>
		      			<td>
		      				<textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048"><%=bbs.getBbsContent()%></textarea>
		      			</td>
		      		</tr>
		      	</tbody>
	      </table>
	      
	      <div class="d-flex justify-content-end mt-3 mb-3">
	      	<div class="btn-group">
	      		<a href="bbs.jsp" class="btn btn-secondary">목록</a>	
	      		<input type="submit" class="btn btn-success" value="수정하기">	
	      	</div>
	      </div>
      	</form>
      
      </div>
   </div>
</div>

<%@include file="include/footer.jsp"%>
</body>
</html>