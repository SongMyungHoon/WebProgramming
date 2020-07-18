package dao;

import java.sql.*;
import domain.*;
import java.util.*;

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
	public void dbConnect() {
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
	
	/* "R"ead
	 * select query를 수행하는 method
	 * parameter로 받는 studentId에 해당하는 student의 정보를 domain.Student 객체로 return */
	public void connectionTest() {
		dbConnect(); // database Connection 생성
		Statement statement;
		ResultSet resultSet;
		// SELECT query문 
		String query = "show databases;";
		
		try {
			if(connection != null) {
				// studentId를 조건절에 대입해야하므로 PrepareStatment 사용
				statement = connection.createStatement();
				
				/* executeQuery: SELECT문만 실행 가능
				 * return: ResultSet object */
				resultSet = statement.executeQuery(query);
				while(resultSet.next()) {
					System.out.println(resultSet.getString(1));
				}
				// object closing part
				statement.close();
				resultSet.close();
				connection.close();
			} else {
				System.out.println("Connection isNull");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void createTable() {
		dbConnect(); // database Connection 생성
		Statement statement = null;
		StringBuilder stringBuilder = new StringBuilder();
		// examtable creation query
		String query = stringBuilder.append("create table if not exists gongji(")
						.append("id int not null primary key auto_increment,")
						.append("title varchar(70),")
						.append("date date,")
						.append("content text);")
						.toString();
		try {
			if(connection != null) {
				statement = connection.createStatement();
				if(statement != null) {
					statement.execute(query);
					statement.close();
				}
				// object closing part
				connection.close();
			} else {
				System.out.println("Connection isNull");
			}
		} catch (SQLException e) {
			System.out.println("create table 실패");
			e.printStackTrace();
		}  finally {
			try{
				if(statement != null) {
					statement.close();
				}
				if(connection != null) {
					connection.close();
				}
			} catch (Exception error) {
				System.out.println("Closing error");
				error.printStackTrace();
			}
		}
		System.out.println("table gongji creation success");
	}
	
	public void insertTestData() {
		dbConnect(); // database Connection 생성
		Statement statement = null;
		StringBuilder stringBuilder = new StringBuilder();
		// examtable creation query
		String query = stringBuilder.append("insert into gongji (title, date, content) values ")
						.append("('공지사항1', date(now()),'공지사항내용1'),")
						.append("('공지사항2', date(now()),'공지사항내용2'),")
						.append("('공지사항3', date(now()),'공지사항내용3'),")
						.append("('공지사항4', date(now()),'공지사항내용4'),")
						.append("('공지사항5', date(now()),'공지사항내용5');")
						.toString();
		try {
			if(connection != null) {
				statement = connection.createStatement();
				if(statement != null) {
					statement.execute(query);
					statement.close();
				}
				// object closing part
				connection.close();
			} else {
				System.out.println("Connection isNull");
			}
		} catch (SQLException e) {
			System.out.println("insert 실패");
			e.printStackTrace();
		}  finally {
			try{
				if(statement != null) {
					statement.close();
				}
				if(connection != null) {
					connection.close();
				}
			} catch (Exception error) {
				System.out.println("Closing error");
				error.printStackTrace();
			}
		}
		System.out.println("test data insertion success");
	}
	
	public void dropTable() {
		dbConnect(); // database Connection 생성
		Statement statement = null;
		String query = "drop table if exists gongji;";
		
		try {
			if(connection != null) {
				statement = connection.createStatement();
				if(statement != null) {
					/* executeUpdate method
					 * : INSERT, UPDATE, DELETE같은 DML sql이나 반환값이 없는 DDL문 수행가능
					 * return: (int) affectedRows count */
					statement.executeUpdate(query);
					statement.close();
				}
				// object closing part
				connection.close();
			} else {
				System.out.println("Connection isNull");
			}
		} catch (SQLException e) {
			System.out.println("table 삭제 실패");
			e.printStackTrace();
		}  finally {
			try{
				if(statement != null) {
					statement.close();
				}
				if(connection != null) {
					connection.close();
				}
			} catch (Exception error) {
				System.out.println("Closing error");
				error.printStackTrace();
			}
		}
		System.out.println("테이블 삭제 OK");
	}
	
	/* "R"ead
	 * select query를 수행하는 method
	 * parameter로 받는 id에 해당하는 post의 정보를 domain.Post 객체로 return */
	public Post selectOne(int postId) {
		dbConnect(); // database Connection 생성
		PreparedStatement preparedStatement;
		ResultSet resultSet;
		// SELECT query문 
		String query = "select * from gongji where id = ?;";
		Post post = null;
		try {
			if(connection != null) {
				// studentId를 조건절에 대입해야하므로 PrepareStatment 사용
				preparedStatement = connection.prepareStatement(query);
				preparedStatement.setInt(1, postId);
				/* executeQuery: SELECT문만 실행 가능
				 * return: ResultSet object */
				resultSet = preparedStatement.executeQuery();
				
				while(resultSet.next()) {
					// query 수행 결과 return 받은 ResultSet으로 Post 객체 생성
					post = new Post(resultSet.getInt("id")
										, resultSet.getString("title")
										, resultSet.getDate("date")
										, resultSet.getString("content"));
				}
				// object closing part
				preparedStatement.close();
				resultSet.close();
				connection.close();
			} else {
				System.out.println("Connection isNull");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return post;	// query 수행 결과 생성한 Student object return
	}
	
	/* "R"ead
	 * SELECT query를 수행하여 Table의 모든 record를 출력하는 method 
	 * return: Student를 data object로 하는 List */
	public List<Post> selectAll() {
		dbConnect();
		Statement statement = null;
		ResultSet resultSet = null;
		String query = "select * from gongji;";
		
		List<Post> postList = new ArrayList<>();
		try {
			if(connection != null) {
				statement = connection.createStatement();
				/* executeQuery: SELECT문만 실행 가능
				 * return: ResultSet object */
				resultSet = statement.executeQuery(query);
				while(resultSet.next()) {
					postList.add(new Post(resultSet.getInt("id")
										, resultSet.getString("title")
										, resultSet.getDate("date")
										, resultSet.getString("content")));
				}
				// object closing part
				statement.close();
				resultSet.close();
				connection.close();
			} else {
				System.out.println("Connection isNull");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try{
				if(resultSet != null) {
					resultSet.close();
				}
				if(statement != null) {
					statement.close();
				}
				if(connection != null) {
					connection.close();
				}
			} catch (Exception error) {
				System.out.println("Closing error");
				error.printStackTrace();
			}
		}
		return postList;
	}
	
}
