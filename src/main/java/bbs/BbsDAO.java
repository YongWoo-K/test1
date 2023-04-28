package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


/*
- BbsDAO클래스는 여러개의 메소드가 사용되기 때문에 각각의 메소드가 데이터베이스에 접근함에 있어서
  서로 마찰이 일어나지 않도록 PreparedStatement를 각 메소드 내에 추가하도록 한다.
  
- getDate() : 작성일자를 구하는 메소드

- getNext() : 새로운 게시글 번호를 부여하는 메소드
	-> 	현재 저장되어있는 모든 게시글의 번호를 내림차순으로 정렬하여 가장 상위 게시글 번호를 구하고
	 	그 게시글 번호에 1을 더한 값을 새로 작성되는 게시글 번호로 부여한다.
	- 예시 : 13개의 게시글이 존재할 경우 새로 작성되는 게시글의 번호는 13+1이 된다.

- write() : 글 제목, 사용자 ID, 작성일자, 글 내용, 유효번호 순으로 데이터를 세팅하고 데이터베이스로 전송하는 메소드
*/
public class BbsDAO {
	private Connection conn;
	private ResultSet rs;
	
	
	/*
	 DBCP(DataBase Connection Pool)  
	- 데이터베이스와 연결된 커넥션을 미리 만들어서 저장해두고 있다가 필요할 때 저장된 공간(pool)을 
	  가져다 쓰고 반환하는 기법 
	 
	 기본생성자 -> BbsDAO가 실행되면 자동으로 생성되는 부분
	-> DriverManager에 저장한 dbID와 dbPassword를 사용해 dbURL로 접속하여 데이터베이스에 연결한다.
	 */
	public BbsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/bbs";
			String dbID = "root";
			String dbPassword = "12345678!";
			Class.forName("com.mysql.jdbc.Driver");
//			class.forName() : 로딩하고자 하는 클래스명으로 클래스를 찾아 로드한다.
//		 	- Class.forName("com.mysql.jdbc.Driver");
//		 		-> jdbc패키지의 Driver 클래스를 'String'타입으로 불러온다.
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//작성일자 메소드
	public String getDate() {
		String sql = "select now()"; //현재 시간을 나타내주는 쿼리문을 변수에 저장
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql); //쿼리문 대기
			rs = pstmt.executeQuery(); //쿼리문 실행 결과값을 변수에 저장
			
			//rs에 값이 존재한다면 그 값을 리턴
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스에 오류가 발생하여 try~catch문 실행이 불가능할 경우 리턴
	}
	
	//게시글 번호 부여 메소드
	public int getNext() {
		//현재 게시글들을 내림차순으로 조회하여 가장 마지막 글의 번호를 구하는 쿼리문을 변수에 저장
		String sql = "select bbsID from bbs order by bbsID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql); //쿼리문 대기
			rs = pstmt.executeQuery(); //쿼리문 실행 결과값을 변수에 저장
			
			//변수에 값이 존재한다면
			if(rs.next()) {
				//그 값에 +1한 값을 리턴한다.
				return rs.getInt(1)+1;
			}
			return 1;//첫번째 게시글일 경우 1을 리턴
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스에 오류가 발생하여 try~catch문 실행이 불가능할 경우 -1 리턴
	}
	
	//글쓰기 메소드
	public int write(String bbsTitle, String userID, String bbsContent) {
		String sql = "insert into bbs values(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql); //쿼리문 대기			
			pstmt.setInt(1, getNext()); //첫번째 '?'에 게시글 번호 부여
			pstmt.setString(2, bbsTitle); //두번째 '?'에 매개변수로 받아온 bbsTitle 부여
			pstmt.setString(3, userID); //세번째 '?'에 매개변수로 받아온 userID 부여
			pstmt.setString(4, getDate()); //네번째 '?'에 현재 날짜 부여
			pstmt.setString(5, bbsContent); //다섯번째 '?'에 매개변수로 받아온 bbsContent 부여
			pstmt.setInt(6, 1); //다섯번째 '?'에 글의 유효번호 부여 -> 이후 삭제가 아닌 유효성 상실을 통해 삭제
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
		return -1;
	}
	
	/*
	  게시글 목록 출력
	  - ArrayList<Bbs> getList(int pageNumber) : 현재 페이지의 게시글 목록을 리스트의 형태로 받아온다.
	  - "select * from bbs where bbsID < ? and bbsAvailable = 1 order by bbsID desc limit 10"
	  		-> 모든 게시글을 조회
	  		-> 유효번호가 존재하고 새롭게 작성될 게시글의 게시글번호보다 작은 게시글번호를 가진 게시글을 내림차순으로 최대 10개까지 조회
	  - 현재 게시글이 5개라면 getNext() = 6, 6보다 작은 5개의 게시글이 출력
	  - while(rs.next()) -> 결과값이 존재하는 동안 각각의 요소를 담아 하나의 리스트를 완성하여 getList를 리턴 
	  - 게시글이 10개 -> 페이징x, 게시글 11개 -> 새로운 페이지 설정
	 */
	//게시글 리스트 메소드
	public ArrayList<Bbs> getList(int pageNumber){
		ArrayList<Bbs> List = new ArrayList<>();
		String sql = "select * from bbs where bbsID < ? and bbsAvailable = 1 order by bbsID desc limit 10";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber-1) * 10); //-> 첫번쨰 '?'에 getNext() - (pageNumber-1) * 10 을 넣어줌
			//getNext() - (pageNumber-1) * 10 = 다음에 쓰여질 게시글의 번호 - (현재 페이지번호 -1) * 10
			rs = pstmt.executeQuery(); //쿼리문 실행 결과값을 rs에 할당
			
			//결과값이 존재한다면
			while(rs.next()) {
				//Bbs클래스의 객체 bbs를 만들고 bbs의 변수 값을 rs의 값으로 설정하고 list에 삽입한다.
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				List.add(bbs);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return List; //리스트 출력
	}
	
	/*
	 페이징 처리 함수 : 게시글을 10개 단위로 끊어서 새로운 페이지를 만들어 주는 함수  
	 */
	//페이징 처리 메소드
	public boolean nextPage(int pageNumber) {
		String sql = "select * from bbs where bbsID < ? and bbsAvailable = 1";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber-1) * 10);
			rs = pstmt.executeQuery();
			/*
			 executeQuery() : 수행결과로 ResultSet 객체의 값을 반환
			 	-> SELECT 구문을 수행할 때 사용되는 함수
			 	-> ResultSet 객체에 결과값을 담을 수 있다.
			 */
			
			//결과값이 존재한다면 다음으로 넘어갈 수 있는 true를 리턴
			if(rs.next()) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false; //결과값이 존재하지 않는다면 false를 리턴
	}
	
	/*
	 하나의 게시글을 보는 메소드 getBbs()
	 -> 매개변수로 넘어온 'bbsID'에 데이터가 존재한다면 그 데이터에 맞는 'Bbs'객체를 생성하고
	    해당 내용들을 모두 불러와 정보들을 리턴해주는 메서드
	 */
	public Bbs getBbs(int bbsID) {
		String sql = "select * from bbs where bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/*
	 게시글 수정 메소드 update()
	 -> 매개변수로 게시글 번호, 게시글 제목, 게시글 내용을 받아와서 데이터 수정을 해주는 메소드
	 
	 게시글 삭제 매소드 delete()
	 -> 매개변수로 게시글 번호를 받아와서 게시글 번호에 해당하는 게시글의 유효숫자를 0으로 변경하여
	 	게시글을 유효하지 않은 글로 수정하는 메소드
	 */
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String sql = "update bbs set bbsTitle = ?, bbsContent = ? where bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int bbsID) {
		String sql = "update bbs set bbsAvailable = 0 where bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
