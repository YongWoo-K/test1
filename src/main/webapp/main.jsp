<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<title>Main</title>
</head>
<body>
<%@include file="include/header.jsp"%>

<div class="container-fluid p-0">
	<div id="demo" class="carousel slide" data-bs-ride="carousel">
	
		<%-- preview next --%>
		<div class="carousel-indicators">
   			<button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active">
   			</button>
   			<button type="button" data-bs-target="#demo" data-bs-slide-to="1">
   			</button>
   			<button type="button" data-bs-target="#demo" data-bs-slide-to="2">
   			</button>
   		</div>	
   		   
   		<%-- slide image --%>
   		<div class="carousel-inner mw-100">
   			<div class="carousel-item active">
   				<img src="img/slide/1.jpg" alt="" class="d-block mw-100">
   			</div>
   				
   			<div class="carousel-item active">
   				<img src="img/slide/2.jpg" alt="" class="d-block mw-100">
   			</div>
   				
   			<div class="carousel-item active">
   				<img src="img/slide/3.jpg" alt="" class="d-block mw-100">
   			</div>
   		</div>
   			
   		<%-- left and right controls --%>
   		<button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
   			<span class="carousel-control-prev-icon"></span>
   		</button>
   			
   		<button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
   			<span class="carousel-control-next-icon"></span>
   		</button>
   			
	</div>
</div>

<%@include file="include/footer.jsp"%>
</body>
</html>