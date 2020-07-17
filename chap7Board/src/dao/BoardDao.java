package dao;

import java.sql.*;

public class BoardDao {
	// Dao 클래스에서 사용될 공유 connection 객체
	private static Connection connection;
	// singleton pattern applied default constructor
	private BoardDao() {}
	// declaring Lazy-Holder(중첩 클래스)
	private static class LazyHolder {
		/* static: 클래스 로딩 시점에 한번만 호출됨
		 * final: 값이 다시 할당되지 않음 */
		private static final BoardDao instance = new BoardDao();
	}
	// getInstance method 호출 시 LazyHolder 호출
	public static BoardDao getInstance() {
		return LazyHolder.instance;
	}
	// database(MySQL)과 연동시켜 관련 정보를 static Connection 객체에 저장
	public static void dbConnect() {
		final String id = "root";
		final String password = "qortjf90";
		final String accessURL = "jdbc:mysql://localhost:3306/"
				+ "?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Seoul"
				+ "&allowPublicKeyRetrieval=true&useSSL=false";
		final String dbName = "crudboard";
		
		try {
			/* jsp에서는 Class.forName 코드를 사용하지 않으면 Connection이 이루어 지지 않는다.
			 * 반드시 기재할 것! */
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(accessURL, id, password);
			connection.setCatalog(dbName); // using database
		} catch (ClassNotFoundException e) {
			// Class.forName method에서 발생가능한 ClassNotFoundException catch
			e.printStackTrace();	
		} catch(SQLException exception) {
			exception.printStackTrace();
		}
	}
}
