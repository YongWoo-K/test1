<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="css/custom.css">
<title>BBS</title>
</head>
<body class="bg-gradient-primary">

<%@include file="include/header.jsp"%>

<div class="container">
   <div class="row justify-content-center">
      <div class="col-xl-10 col-lg-12 col-md-9">
      
      	<div class="card o-hidden border-0 shadow-lg my-5">
      		<div class="card-body p-0">
      			<div class="row">
      			
      				<div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
      				
      				<div class="col-lg-6">
      					<div class="p-5">
      						<form method="post" action="loginAction.jsp">
      							<div class="text-center">
	      							<h1 class="mb-4 text-gray-900 h4">Welcome back!</h1>
	      						</div>
	      						
	      						<div class="form-group mt-3">
	      							<input 
	      							type="text" 
	      							class="form-control rounded-5" 
	      							placeholder="enter your ID"
	      							name="userID"
	      							maxlength="20"
	      							>
	      						</div>
	      						
	      						<div class="form-group mt-3">
	      							<input 
	      							type="password" 
	      							class="form-control rounded-5" 
	      							placeholder="enter your Password"
	      							name="userPassword"
	      							maxlength="20"
	      							>
	      						</div>
	      						
	      						<input type="submit" class="btn btn-primary form-control rounded-5" value="로그인">
      						</form>
      						
      						<div class="text-center">
      							<a class="small" href="join.jsp">
      								Create an Account!
      							</a>
      						</div>
      					</div>
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