package dao;

import java.sql.*;
import domain.*;
import java.util.*;

public class ReBoardDao {
	// Dao 클래스에서 사용될 공유 connection 객체
	private static Connection connection;
	
	// singleton pattern applied default constructor
	private ReBoardDao() {}
	
	// declaring Lazy-Holder(중첩 클래스)
	private static class LazyHolder {
		/* static: 클래스 로딩 시점에 한번만 호출됨
		 * final: 값이 다시 할당되지 않음 */
		private static final ReBoardDao instance = new ReBoardDao();
	}
	
	// getInstance method 호출 시 LazyHolder 호출
	public static ReBoardDao getInstance() {
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
		
	public void connectionTest() {
		dbConnect(); // database Connection 생성
		Statement statement;
		ResultSet resultSet;
		// SELECT query문 
		String query = "show databases;";
		
		try {
			if(connection != null) {

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
	
	// Table 생성
	public void createTable() {
		dbConnect(); // database Connection 생성
		Statement statement = null;
		StringBuilder stringBuilder = new StringBuilder();
		// gongji table creation query
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
	
	// test용 data를 insert
	public void insertTestData() {
		dbConnect(); // database Connection 생성
		Statement statement = null;
		StringBuilder stringBuilder = new StringBuilder();
		// Test data insert query
		 
		stringBuilder.append("insert into gongji (title, date, content) values ");
		for(int i = 0; i < 100; i++) {
			stringBuilder.append("('공지사항").append(i).append("', date(now()),'").append(i).append("')");	
			if(i == 99) {
				stringBuilder.append(";");
			} else {
				stringBuilder.append(",");
			}
		}
		String query = stringBuilder.toString();
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
	
	// test용 data를 insert
	public void addField() {
		dbConnect(); // database Connection 생성
		Statement statement = null;
		StringBuilder stringBuilder = new StringBuilder();
		// Test data insert query
		String query = stringBuilder.append("alter table gongji add( ")
						.append("rootid int default 0, ")
						.append("relevel int default 0, ")
						.append("recnt int default 0, ")
						.append("viewcnt int default 0);")
						.toString();
		try {
			if(connection != null) {
				statement = connection.createStatement();
				if(statement != null) {
					statement.execute(query);
					statement.execute("update gongji set rootid = id where rootid = 0;");
					statement.close();
				}
				// object closing part
				connection.close();
			} else {
				System.out.println("Connection isNull");
			}
		} catch (SQLException e) {
			System.out.println("field 추가 실패");
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
		System.out.println("Complete add field");
	}
	
	// Table 삭제
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
	public RePost selectOne(int postId) {
		dbConnect(); // database Connection 생성
		PreparedStatement preparedStatement;
		ResultSet resultSet;
		// SELECT query문 
		String query = "select * from gongji where id = ?;";
		RePost post = null;
		try {
			if(connection != null) {
				// postId를 조건절에 대입해야하므로 PrepareStatment 사용
				preparedStatement = connection.prepareStatement(query);
				preparedStatement.setInt(1, postId);
				/* executeQuery: SELECT문만 실행 가능
				 * return: ResultSet object */
				resultSet = preparedStatement.executeQuery();
				
				while(resultSet.next()) {
					// query 수행 결과 return 받은 ResultSet으로 Post 객체 생성
					post = new RePost(resultSet.getInt("id")
									, resultSet.getString("title")
									, resultSet.getDate("date")
									, resultSet.getString("content")
									, resultSet.getInt("rootid")
									, resultSet.getInt("relevel")
									, resultSet.getInt("recnt")
									, resultSet.getInt("viewcnt"));
				}
				System.out.println("selectOne method operated");
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
		return post;	// query 수행 결과 생성한 Post object return
	}
	
	/* "R"ead
	 * select query를 수행하는 method
	 * parameter로 받는 id에 해당하는 post의 정보를 domain.Post 객체로 return */
	public int lastInsertedPostId() {
		dbConnect(); // database Connection 생성
		Statement statement = null;
		ResultSet resultSet = null;
		// id 기준 내림차순 정렬
		String query = "select max(id) as max_id from gongji;";
		int lastId = 0;
		try {
			if(connection != null) {
				statement = connection.createStatement();
				/* executeQuery: SELECT문만 실행 가능
				 * return: ResultSet object */
				resultSet = statement.executeQuery(query);
				while(resultSet.next()) {
					lastId = resultSet.getInt("max_id");
				}
				System.out.println("lastInsertedPostID method operated");
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
		return lastId;
	}
	
	/* "R"ead
	 * SELECT query를 수행하여 Table의 모든 record를 출력하는 method 
	 * return: Post를 data object로 하는 List */
	public List<RePost> selectAll() {
		dbConnect();
		Statement statement = null;
		ResultSet resultSet = null;
		// id 기준 내림차순 정렬
		String query = "select * from gongji order by rootid desc, recnt asc;";
		
		List<RePost> postList = new ArrayList<>();
		try {
			if(connection != null) {
				statement = connection.createStatement();
				/* executeQuery: SELECT문만 실행 가능
				 * return: ResultSet object */
				resultSet = statement.executeQuery(query);
				while(resultSet.next()) {
					postList.add(new RePost(resultSet.getInt("id")
										  , resultSet.getString("title")
										  , resultSet.getDate("date")
										  , resultSet.getString("content")
										  , resultSet.getInt("rootid")
										  , resultSet.getInt("relevel")
										  , resultSet.getInt("recnt")
								 		  , resultSet.getInt("viewcnt")));
				}
				System.out.println("selectAll method operated");
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
	
	/* "R"ead
	 * select query를 수행하는 method
	 * parameter로 받는 rootId에 해당하는 post의 recnt 값 중 가장 큰 값을 조회 */
	public int selectReCnt(int rootId) {
		dbConnect(); // database Connection 생성
		PreparedStatement preparedStatement;
		ResultSet resultSet;
		// SELECT query문 
		String query = "select ifnull(max(recnt),0) as max_recnt from gongji where rootid = ?;";
		int reCnt = 0;
		try {
			if(connection != null) {
				// rootId를 조건절에 대입해야하므로 PrepareStatment 사용
				preparedStatement = connection.prepareStatement(query);
				preparedStatement.setInt(1, rootId);
				/* executeQuery: SELECT문만 실행 가능
				 * return: ResultSet object */
				resultSet = preparedStatement.executeQuery();
				
				while(resultSet.next()) {
					// query 수행 결과 return 받은 ResultSet으로 recnt 값 받음
					reCnt = resultSet.getInt("max_recnt");
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
		return reCnt;	// query 수행 결과 반환받는 recnt 값 return
	}
	
	public RePost lastInsertedPost(int rootId, int relevel, int recnt) {
		dbConnect(); // database Connection 생성
		PreparedStatement preparedStatement;
		ResultSet resultSet;
		// SELECT query문 
		String query = "select * from gongji where rootid = ? and relevel = ? and recnt = ?;";
		RePost post = null;
		try {
			if(connection != null) {
				// postId를 조건절에 대입해야하므로 PrepareStatment 사용
				preparedStatement = connection.prepareStatement(query);
				preparedStatement.setInt(1, rootId);
				preparedStatement.setInt(2, relevel);
				preparedStatement.setInt(3, recnt);
				/* executeQuery: SELECT문만 실행 가능
				 * return: ResultSet object */
				resultSet = preparedStatement.executeQuery();
				
				while(resultSet.next()) {
					// query 수행 결과 return 받은 ResultSet으로 Post 객체 생성
					post = new RePost(resultSet.getInt("id")
										, resultSet.getString("title")
										, resultSet.getDate("date")
										, resultSet.getString("content")
										, resultSet.getInt("rootid")
										, resultSet.getInt("relevel")
										, resultSet.getInt("recnt")
										, resultSet.getInt("viewcnt"));
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
		return post;	// query 수행 결과 생성한 Post object return
	}
	
	/* "R"ead
	 * SELECT query를 수행하여 Table의 모든 record를 출력하는 method 
	 * return: Post를 data object로 하는 List */
	public List<RePost> selectAllRootPost() {
		dbConnect();
		Statement statement = null;
		ResultSet resultSet = null;
		// id 기준 내림차순 정렬
		String query = "select * from gongji where relevel = 0 order by id desc;";
		
		List<RePost> postList = new ArrayList<>();
		try {
			if(connection != null) {
				statement = connection.createStatement();
				/* executeQuery: SELECT문만 실행 가능
				 * return: ResultSet object */
				resultSet = statement.executeQuery(query);
				while(resultSet.next()) {
					postList.add(new RePost(resultSet.getInt("id")
										, resultSet.getString("title")
										, resultSet.getDate("date")
										, resultSet.getString("content")
										, resultSet.getInt("rootid")
										, resultSet.getInt("relevel")
										, resultSet.getInt("recnt")
										, resultSet.getInt("viewcnt")));
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
	
	// D: 특정 Post를 Database에서 삭제하는 query 수행
	public boolean delete(int postId) {
		dbConnect(); // database Connection 생성
		PreparedStatement preparedStatement = null;
		String query = "delete from gongji where id = ?;";
		try {
			if(connection != null) {
				// 입력할 data가 미정이므로 PrepareStatement 객체 사용
				preparedStatement = connection.prepareStatement(query);
				preparedStatement.setInt(1, postId);
				/* executeUpdate method
				 * : INSERT, UPDATE, DELETE같은 DML sql이나 반환값이 없는 DDL문 수행가능
				 * return: (int) affectedRows count */
				preparedStatement.executeUpdate();
				
				// object closing part
				preparedStatement.close();
				connection.close();
			} else {
				System.out.println("Connection isNull");
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			try{
				if(preparedStatement != null) {
					preparedStatement.close();
				}
				if(connection != null) {
					connection.close();
				}
			} catch (Exception error) {
				System.out.println("Closing error");
				error.printStackTrace();
				return false;
			}
		}
		return true;
	}
	// U: 새로운 게시글을 Database에 저장하는 insert query를 수행
	public boolean insert(RePost post) {
		dbConnect(); // database Connection 생성
		PreparedStatement preparedStatement = null;
		StringBuilder stringBuilder = new StringBuilder();
		// Post data insert query
		String query = stringBuilder.append("insert into gongji (title, date, content) values ")
						.append("(?, date(now()),?);").toString();
		try {
			if(connection != null) {
				preparedStatement = connection.prepareStatement(query);
				if(preparedStatement != null) {
					preparedStatement.setString(1, post.getTitle());
					preparedStatement.setString(2, post.getContent());
					preparedStatement.executeUpdate();
					preparedStatement.close();
				}
				// object closing part
				connection.close();
			} else {
				System.out.println("Connection isNull");
				return false;
			}
		} catch (SQLException e) {
			System.out.println("insert 실패");
			e.printStackTrace();
			return false;
		}  finally {
			try{
				if(preparedStatement != null) {
					preparedStatement.close();
				}
				if(connection != null) {
					connection.close();
				}
			} catch (Exception error) {
				System.out.println("Closing error");
				error.printStackTrace();
				return false;
			}
		}
		return true;
	}
	// U: 새로운 게시글을 Database에 저장하는 insert query를 수행
	public boolean reInsert(RePost rePost) {
		dbConnect(); // database Connection 생성
		PreparedStatement preparedStatement = null;
		StringBuilder stringBuilder = new StringBuilder();
		// Post data insert query
		String query = stringBuilder.append("insert into gongji (title, date, content, rootid, relevel, recnt) ")
						.append("values (?, date(now()),?,?,?,?);").toString();
		try {
			if(connection != null) {
				preparedStatement = connection.prepareStatement(query);
				if(preparedStatement != null) {
					preparedStatement.setString(1, rePost.getTitle());
					preparedStatement.setString(2, rePost.getContent());
					preparedStatement.setInt(3, rePost.getRootId());
					preparedStatement.setInt(4, rePost.getRelevel());
					preparedStatement.setInt(5, rePost.getRecnt());
					preparedStatement.executeUpdate();
					preparedStatement.close();
				}
				// object closing part
				connection.close();
			} else {
				System.out.println("Connection isNull");
				return false;
			}
		} catch (SQLException e) {
			System.out.println("reInsert 실패");
			e.printStackTrace();
			return false;
		}  finally {
			try{
				if(preparedStatement != null) {
					preparedStatement.close();
				}
				if(connection != null) {
					connection.close();
				}
			} catch (Exception error) {
				System.out.println("Closing error");
				error.printStackTrace();
				return false;
			}
		}
		return true;
	}
	// U: 특정 Post의 데이터를 Database에서 수정하는 query 수행
	public boolean update(RePost post) {
		dbConnect(); // database Connection 생성
		PreparedStatement preparedStatement = null;
		String query = "update gongji set title = ?, date = ?, content = ? "
				+ "where id = ?;";
		try {
			if(connection != null) {
				// 입력할 data가 미정이므로 PrepareStatement 객체 사용
				preparedStatement = connection.prepareStatement(query);
				preparedStatement.setString(1, post.getTitle());
				preparedStatement.setDate(2, post.getDate());
				preparedStatement.setString(3, post.getContent());
				preparedStatement.setInt(4, post.getId());
				
				/* executeUpdate method
				 * : INSERT, UPDATE, DELETE같은 DML sql이나 반환값이 없는 DDL문 수행가능
				 * return: (int) affectedRows count */
				preparedStatement.executeUpdate();
				
				// object closing part
				preparedStatement.close();
				connection.close();
			} else {
				System.out.println("Connection isNull");
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			try{
				if(preparedStatement != null) {
					preparedStatement.close();
				}
				if(connection != null) {
					connection.close();
				}
			} catch (Exception error) {
				System.out.println("Closing error");
				error.printStackTrace();
				return false;
			}
		}
		return true;
	}
	
	// U: 특정 Post의 데이터를 Database에서 수정하는 query 수행
	public void viewCntUpdate(RePost post) {
		dbConnect(); // database Connection 생성
		PreparedStatement preparedStatement = null;
		String query = "update gongji set viewcnt = ? where id = ?;";
		try {
			if(connection != null) {
				// 입력할 data가 미정이므로 PrepareStatement 객체 사용
				preparedStatement = connection.prepareStatement(query);
				preparedStatement.setInt(1, post.getViewcnt());
				preparedStatement.setInt(2, post.getId());
				
				/* executeUpdate method
				 * : INSERT, UPDATE, DELETE같은 DML sql이나 반환값이 없는 DDL문 수행가능
				 * return: (int) affectedRows count */
				preparedStatement.executeUpdate();
				
				// object closing part
				preparedStatement.close();
				connection.close();
			} else {
				System.out.println("Connection isNull");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try{
				if(preparedStatement != null) {
					preparedStatement.close();
				}
				if(connection != null) {
					connection.close();
				}
			} catch (Exception error) {
				System.out.println("Closing error");
				error.printStackTrace();
			}
		}
	}
}
