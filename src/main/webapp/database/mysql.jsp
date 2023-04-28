<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<title>mySQL의 기초문법</title>
</head>
<body>
<div class="container">
   <div class="row">
      <div class="col-12">
      
      <h1>mysql 기초문법</h1>
      <pre>
      	- 데이터베이스 생성
      		- create database [데이터베이스명] character set[캐릭터 셋]
      		
      		- 예시
      		create database bbs account character set utf8mb4 collate utf8mb4_general_ci;
      			-> ci는 case-insensitive에 약자이며 대소문자를 구분하지 않음.
      	
      	- 데이터베이스 삭제
      		- drop database [데이터베이스명];
      	
      	- 테이블 생성
      		- create table 테이블명(
      		      열1, 열2, ....
      		  )
      		  
      	- 테이블 삭제
      		- drop table 테이블명;
      </pre>
      
      <h1>테이블 업데이트</h1>
      <pre>
      	- 테이블에 필드(열) 추가
      		- alter table [테이블명] add [열 이름] [데이터타입];
      		<mark>ex) ALTER TABLE User ADD PhoneNumber INT;</mark><br>
      		 
      	- 테이블 필드(열)의 타입 변경
      		- alter table [테이블명] modify column [열 이름] [데이터타입];
      		<mark>ex) ALTER TABLE User MODIFY COLUMN ID VARCHAR;</mark><br>
      	
      	- 테이블 필드(열) 삭제
      		- alter table [테이블명] drop [열 이름];
      		<mark>ex) ALTER TABLE User DROP Age;</mark><br>
      		
      	- 테이블에 레코드 행 추가
      		- insert into [테이블명] (column1, column2, column3,...) values (value1, value2, value3,....);
      		<mark>ex) INSERT INTO User (ID, Name, Birth) VALUES (1, '이름', '1900-11-12');</mark><br>
      
      	- 테이블을 선택
      		- select * from [테이블명];
      		<mark>ex) SELECT * FROM User;</mark><br>
      	
      	- 테이블의 레코드 행 수정
      		- update [테이블명] set [열이름] = [value] where [조건];
      		<mark>ex) UPDATE User SET Age = 30 WHERE Name = 'some';</mark><br>
      	
      	- 테이블의 레코드 행 삭제
      		- delete from [테이블명] where [조건];
      		<mark>ex) DELETE FROM User WHERE Name = 'some';</mark><br>
      </pre>
      
      </div>
   </div>
</div>

</body>
</html>