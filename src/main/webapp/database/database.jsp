<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<title>데이터베이스</title>
</head>
<body>
<div class="container">
   <div class="row">
      <div class="col-12">
      
      <h1>데이터베이스 개요</h1>
      <pre>
      	- DBMS : DataBase Management System
      		- mysql, MS-SQL, ORACLE 등이 해당
      	
      	- JDBC : Java DataBase Connectivity
      </pre>
      
      <h1>SQL</h1>
      <pre>
      	- 데이터 정의문(DDL) : CREATE, ALTER, DROP
      	- 데이터 제어문(DCL) : GRANT, REVOKE
      	- 데이터 조작문(DML) : SELECT, INSERT, DELETE
      	- 쿼리 : select 
      	- 트랜잭션(Transaction) 처리 : COMMIT, ROLLBACK
      </pre>
      
      <h1>숫자 타입</h1>
      <pre>
      	- TINYINT : 1 byte
      	- SMALLINT : 2 bytes
      	- MEDIUMINT : 3 bytes
      	- INT, INTEGER : 4 bytes
      	- BIGINT : 8 bytes
      </pre>
      
      <h1>날짜 및 시간 타입</h1>
      <pre>
      	- DATE : 3 bytes
      	- DATETIME : 8 bytes
      	- TIMESTAMP : 4 bytes
      </pre>
      
      <h1>문자열 타입</h1>
      <pre>
      	- char : 1 ~ 255, 고정형 문자열
      	- varchar : 1 ~ 255, 가변형 문자열
      	- 예시 : varchar(20) -> 20 byte만큼의 공간을 할당함 => 20 byte를 넘으면 넘는 데이터는 삭제
      	- char와 varchar의 차이점
      		- char : 고정형 문자열이기 때문에 20byte를 할당했을때 2byte만 사용한 경우 그대로 20 byte를 할당함
      		- varchar : 가변형 문자열이기 때문에 사용하는 만큼 할당함
      		- 메모리 측면에서 varchar가 훨씬 효율적임
      </pre>
      
      <h1>(1)JDBC 드라이버 로드</h1>
      <pre>
      	- mysql의 경우 : Class.forName("com.mysql.jdbc.Driver");
      	- oracle의 경우 : Class.forName("oracle.jdbc.driver.OracleDriver");
      </pre>
      
      <h1>(2)connection 객체 생성</h1>
      <pre>
      	- Connection conn = DriverManage.getConnection("jdbc:mysql://DB포트번호/DB명");
      </pre>
      
      <h1>(3)프로그램 작성 단계</h1>
      <pre>
      	- Statement stmt = conn.createStatement();
      	- PrepareStatement pstmt ...
      </pre>
      
      <h1>(4)쿼리 수행</h1>
      <pre>
      	- 명령되어 있는 것을 수행
      </pre>
      
      <h1>ResultSet 처리</h1>
      <pre>
      	- 
      </pre>      
      
      </div>
   </div>
</div>

</body>
</html>