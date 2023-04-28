package user;

//DAO : Data Access Object
//-> 데이터베이스에 접근

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet; 
/*
 * Connetion = 연결
 * PreparedStatement = 설정 및 실행
 * ResultSet = 결과값
 * */

public class UserDAO {
	private Connection conn; //자바와 데이터베이스를 연결
	private PreparedStatement pstmt; //쿼리문 대기 및 설정
	private ResultSet rs; //결과값 받아오기
	
	/*
	 dbURL : mySQL을 연결시켜주는 주소
	 dbID : mySQL 사용자(root)
	 dbPassword : mySQL 비밀번호
	 class.forName() : 로딩하고자 하는 클래스명으로 클래스를 찾아 로드한다.
	 	- Class.forName("com.mysql.jdbc.Driver");
	 		-> jdbc Driver 클래스를 'String'타입으로 불러온다.
	 	
	 DriverManager.getConnection : 드라이버매니저에 미리 저장했던 연결URL과 DB계정정보를 담아 연결설정을 해준다.
	*/
	
	//기본생성자 -> UserDAO가 실행되면 자동으로 생성되는 부분
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "12345678!";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 로그인 영역
	 sql : Structured Query Language, 구조화된 질의 언어
	 	-> 모든 작업을 통제하는 비절차적 언어
	 String sql : 실제로 db에 입력할 쿼리문을 'sql'변수에 미리 담아둔다.
	 conn.preparedStatement(sql) : 미리 설정한 'sql'을 셋팅하는 코드
	 pstmt.setString(1, userID) : 쿼리문의 '1'번째 물음표에 'userID'를 대입(변수에 값을 할당)
	 rs = pstmt.executeQuery() : 셋팅이 끝난 쿼리문을 실행시키고 나온 결과값을 rs에 저장
	 
	 로그인 결과값에 대한 처리
	 userPassword와 일치한다 => 로그인 성공(정수 1을 리턴)
	 결과값이 존재하지만, 그 결과값이 매개변수로 넘어온 패스워드와 불일치 => 비밀번호 틀림(정수 0을 리턴)
	 쿼리문을 실행했는데 결과값이 나오지않음 => 존재하지 않는 아이디 => 회원정보에 없음(-1을 리턴)
	*/
	public int login(String userID, String userPassword) {
		String sql = "select userPassword from user where userID = ?";
		try {
			pstmt = conn.prepareStatement(sql); //sql쿼리문을 대기시킨다.
			pstmt.setString(1, userID); //첫번째 '?'에 매개변수로 받아온 'userID'를 대입
			rs = pstmt.executeQuery(); //쿼리를 실행한 결과를 rs에 저장
			/*
			 executeQuery() : 수행결과로 ResultSet 객체의 값을 반환
			 	-> SELECT 구문을 수행할 때 사용되는 함수
			 	-> ResultSet 객체에 결과값을 담을 수 있다.
			 */
			
			//여기까지 실행 후 rs.next()의 값이 존재한다면 해당 결과값을 얻을 수 있다.
			if(rs.next()) {
				//비밀번호가 일치할 경우
				if(rs.getString(1).equals(userPassword)){
					return 1; //로그인 성공
				}else {
					return 0; //비밀번호가 틀림
				}		
			}
			return -1; //아이디 없음
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; //데이터베이스 오류
	}
	/*
	 -> 로그인 기능을 담당하는 'login'메소드를 선언하고 매개변수로 실제 사용자가 입력할 아이디(userID)와
	 	비밀번호를 매개변수로 설정
	 	실제 사용자가 입력한 내용을 매개변수에 담아와서 로그인 메소드를 실행할 때 각 위치의 브라우저에서 넘어온 아이디와
	 	비밀번호를 적용시켜 결과를 도출하고 int타입으로 리턴
	 */
	
	/*
	 회원가입 기능을 담당하는 join() 메서드 
	 insert into user values(?,?,?,?,?); -> user테이블에 데이터를 입력하는 쿼리문
	 */
	public int join(User user) {
		String sql = "insert into user values(?,?,?,?,?)"; //실행할 쿼리문
		try {
			pstmt = conn.prepareStatement(sql); //쿼리문 대기
			pstmt.setString(1, user.getUserID()); //첫번쨰 '?'에 사용자가 입력한 'userID'를 세팅 
			pstmt.setString(2, user.getUserPassword()); //두번쨰 '?'에 사용자가 입력한 'userPassword'를 세팅
			pstmt.setString(3, user.getUserName()); //세번쨰 '?'에 사용자가 입력한 'userName'을 세팅
			pstmt.setString(4, user.getUserGender()); //네번쨰 '?'에 사용자가 입력한 'userGender'를 세팅
			pstmt.setString(5, user.getUserEmail()); //다섯번쨰 '?'에 사용자가 입력한 'userEmail'을 세팅
			return pstmt.executeUpdate(); 
			/*
			 executeUpdate() : 수행결과로 Int 타입의 값을 반환
			 	-> SELECT 구문을 제외한 다른 구문을 수행할 때 사용되는 함수
			 	-> INSERT / DELETE / UPDATE 관련 구문에서는 반영된 레코드의 건수를 반환
			 	-> CREATE / DROP 관련 구문에서는 -1 을 반환
			 	
			 실제 DB에서 'insert'를 정상적으로 입력하면 'Query1 ok'라고 뜨는데 그 숫자를 받아온다
			  -> 정상적으로 데이터가 입력되었다면 1이상의 숫자가 리턴된다.(-1은 뭔가 잘못되었을때 리턴된다.)
			 */
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //-> primary key인 아이디의 중복오류발생
	}
}
