<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="css/custom.css">
<title>Write - 글쓰기</title>
</head>
<body>

<%@include file="include/header.jsp"%>

<div class="container">
   <div class="row">
      <div class="col-md-12">
      
      <form action="writeAction.jsp" method="post">
      	<table class="table table-striped">
      		<thead>
      			<tr>
      				<th colspan="2"> <%-- 칸을 합칠 경우 colspan을 사용한다. --%>
      					<h1>게시판 글쓰기 양식</h1>
      				</th>
      			</tr>
      		</thead>
      		
      		<tbody>
      			<tr>
      				<td>글 제목</td>
      				<td>
	      				<input 
	      				type="text" 
	      				class="form-control" 
	      				placeholder="글 제목" 
	      				name="bbsTitle"
	      				maxlength="50"
	      				>
      				</td>
      			</tr>
      			
      			<tr>
      				<td>글 내용</td>
      				<td>
	      				<textarea  
	      				class="form-control" 
	      				placeholder="글 내용" 
	      				name="bbsContent"
	      				maxlength="2048"
	      				rows="15"
	      				></textarea>
      				</td>
      			</tr>
      		</tbody>
      	</table>
      	
      	<div class="d-flex justify-content-end mt-5 mb-5">
      		<input type="submit" class="btn btn-success" value="글쓰기">
      	</div>
      	
      </form>
      
      </div>
   </div>
</div>

<%@include file="include/footer.jsp"%>

</body>
</html>