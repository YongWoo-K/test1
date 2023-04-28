<%--

userID, userPassword, userName, userGender, userEmail

 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="css/custom.css">
<title>Join</title>
</head>
<body class="bg-gradient-primary">
<%@include file="include/header.jsp"%>

<div class="container">
	<div class="row">
		
		<div class="card o-hidden border-0 shadow-lg my-5">
			<div class="card-body p-0">
			      <div class="row">
			      	<div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
			      	
			      	<div class="col-lg-7">
			      		<div class="p-5">
			      			<div class="text-center">
			      				<h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
			      			</div>
			      				
			      			<form method="post" action="joinAction.jsp">
			      				<div class="input-group mt-4">
			      					<label class="input-group-text w15">아이디</label>
			      					<input 
	      							type="text" 
	      							class="form-control w85" 
	      							placeholder="아이디를 입력해주세요."
	      							name="userID"
	      							maxlength="20"
	      							>
			      				</div>
			      				
			      				<div class="input-group mt-4">
			      					<label class="input-group-text w15">비밀번호</label>
			      					<input 
	      							type="password" 
	      							class="form-control w85" 
	      							placeholder="비밀번호를 입력해주세요."
	      							name="userPassword"
	      							maxlength="20"
	      							>
			      				</div>
			      				
			      				<div class="input-group mt-4">
			      					<label class="input-group-text w15">이름</label>
			      					<input 
	      							type="text" 
	      							class="form-control w85" 
	      							placeholder="이름를 입력해주세요."
	      							name="userName"
	      							maxlength="20"
	      							>
			      				</div>
			      				
			      				<div class="input-group mt-4">
			      					<label class="input-group-text w15">성별</label>
			      					<div class="btn-group" data-toggle="buttons">
			      						<label class="btn btn-primary active">
			      							<input type="radio" name="userGender" autocomplete="off" value="남성" checked>남성
			      						</label>
			      						<label class="btn btn-primary">
			      							<input type="radio" name="userGender" autocomplete="off" value="여성" checked>여성
			      						</label>
			      					</div>
			      				</div>
			      				
			      				<div class="input-group mt-4">
			      					<label class="input-group-text w15">이메일 주소</label>
			      					<input 
	      							type="email" 
	      							class="form-control w85" 
	      							placeholder="이메일 주소를 입력해주세요."
	      							name="userEmail"
	      							maxlength="50"
	      							>
			      				</div>
			      				
			      				<div class="input-group mt-4">
			      					<input 
			      					type="submit" 
			      					class="form-control rounded-5 w85 btn btn-primary" 
			      					value="회원가입"
			      					>
			      				</div>
			      			</form>
			      			
			      		</div>	
			      	</div>
			      	
			      </div>	
			</div>
		</div>
   		

	</div>
</div>

<%@include file="include/footer.jsp"%>
</body>
</html>