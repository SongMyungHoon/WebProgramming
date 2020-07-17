package dao;

import domain.Hubo;
import domain.Tupyo;
import java.sql.*;
import java.util.*;

public class VoteDao {
	// Dao 클래스에서 사용될 공유 connection 객체
	private static Connection connection;
	// singleton pattern applied default constructor
	private VoteDao() {}
	// declaring Lazy-Holder(중첩 클래스)
	private static class LazyHolder {
		/* static: 클래스 로딩 시점에 한번만 호출됨
		 * final: 값이 다시 할당되지 않음 */
		private static final VoteDao instance = new VoteDao();
	}
	// getInstance method 호출 시 LazyHolder 호출
	public static VoteDao getInstance() {
		return LazyHolder.instance;
	}
	// database(MySQL)과 연동시켜 관련 정보를 static Connection 객체에 저장
	public static void dbConnect() {
		final String id = "root";
		final String password = "qortjf90";
		final String accessURL = "jdbc:mysql://localhost:3306/"
				+ "?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Seoul"
				+ "&allowPublicKeyRetrieval=true&useSSL=false";
		final String dbName = "votesystem";
		
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
	 * parameter로 받는 id에 해당하는 후보자의 정보를 domain.Hubo 객체로 return */
	public Hubo selectOne(int id) {
		dbConnect(); // database Connection 생성
		PreparedStatement preparedStatement;
		ResultSet resultSet;
		// SELECT query문 
		String query = "select * from hubo_table where id = ?;";
		Hubo hubo = null;
		try {
			if(connection != null) {
				// id를 조건절에 대입해야하므로 PrepareStatment 사용
				preparedStatement = connection.prepareStatement(query);
				preparedStatement.setInt(1, id);
				/* executeQuery: SELECT문만 실행 가능
				 * return: ResultSet object */
				resultSet = preparedStatement.executeQuery();
				
				while(resultSet.next()) {
					// query 수행 결과 return 받은 ResultSet으로 Hubo instance 생성
					hubo = new Hubo(resultSet.getInt("id"), 
									resultSet.getString("name"));
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
		return hubo;	// query 수행 결과 생성한 Hubo instance return
	}
	/* "R"ead
	 * SELECT query를 수행하여 Hubo_table의 모든 record를 출력하는 method 
	 * return: Hubo를 data object로 하는 List */
	public List<Hubo> selectAllHubo() {
		dbConnect();
		Statement statement = null;
		ResultSet resultSet = null;
		String query = "select * from hubo_table;";
		
		List<Hubo> huboList = new ArrayList<>();
		try {
			if(connection != null) {
				statement = connection.createStatement();
				/* executeQuery: SELECT문만 실행 가능
				 * return: ResultSet object */
				resultSet = statement.executeQuery(query);
				
				while(resultSet.next()) {
					huboList.add(new Hubo(resultSet.getInt("id"),
										  resultSet.getString("name")));
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
		return huboList;
	}
	
	/* "R"ead
	 * SELECT query를 수행하여 tupyo_table의 모든 record의 수를 count
	 * return: int totalVoteCount */
	public int selectAllCountTupyo() {
		dbConnect();
		Statement statement = null;
		ResultSet resultSet = null;
		String query = "select count(*) from tupyo_table;";
		
		int totalVoteCount = 0;
		try {
			if(connection != null) {
				statement = connection.createStatement();
				/* executeQuery: SELECT문만 실행 가능
				 * return: ResultSet object */
				resultSet = statement.executeQuery(query);
				
				while(resultSet.next()) {
					totalVoteCount = resultSet.getInt(1);
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
		return totalVoteCount;
	}
	
	/* "R"ead
	 * SELECT query를 수행하여 특정 후보의 득표 수를 count
	 * return: int voteCount */
	public int selectOneCountTupyo(int id) {
		dbConnect();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		String query = "select count(*) from tupyo_table where id = ?;";
		int voteCount = 0;
		try {
			if(connection != null) {
				preparedStatement = connection.prepareStatement(query);
				preparedStatement.setInt(1, id);
				
				/* executeQuery: SELECT문만 실행 가능
				 * return: ResultSet object */
				resultSet = preparedStatement.executeQuery();
				
				while(resultSet.next()) {
					voteCount = resultSet.getInt(1);
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
		} finally {
			try{
				if(resultSet != null) {
					resultSet.close();
				}
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
		return voteCount;
	}
	
	/* "U"pdate
	 * 후보 정보를 받아서 Database에 후보 정보를 등록하는 insert query 수행 */
	public boolean insertHubo(Hubo hubo) {
		dbConnect(); // database Connection 생성
		PreparedStatement preparedStatement = null;
		String query = "insert into hubo_table value (?, ?);";
		try {
			if(connection != null) {
				// 입력할 data가 미정이므로 PrepareStatement 객체 사용
				preparedStatement = connection.prepareStatement(query);
				preparedStatement.setInt(1, hubo.getId());
				preparedStatement.setString(2, hubo.getName());
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

	// 특정 후보를 Database에서 삭제하는 query 수행
	public boolean delete(int id) {
		dbConnect(); // database Connection 생성
		PreparedStatement preparedStatement = null;
		String query = "delete from hubo_table where id = ?;";
		try {
			if(connection != null) {
				// 입력할 data가 미정이므로 PrepareStatement 객체 사용
				preparedStatement = connection.prepareStatement(query);
				preparedStatement.setInt(1, id);
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
	
	/* "U"pdate
	 * 투표 정보를 Database의 tupyo_table에 저장하는 insert query 수행 */
	public boolean insertTupyo(Tupyo tupyo) {
		dbConnect(); // database Connection 생성
		PreparedStatement preparedStatement = null;
		String query = "insert into Tupyo_table value (?, ?);";
		try {
			if(connection != null) {
				// 입력할 data가 미정이므로 PrepareStatement 객체 사용
				preparedStatement = connection.prepareStatement(query);
				preparedStatement.setInt(1, tupyo.getId());
				preparedStatement.setInt(2, tupyo.getAge());
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
	
	/* "R"ead
	 * 특정 후보의 연령대 별 득표수를 조회하는 SELECT query 수행 */
	public List<List<Integer>> selectTupyoCountEachAge(int id) {
		dbConnect();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		String query = "select age, count(*) from tupyo_table where id = ? group by age;";
		List<List<Integer>> ageDependency = new ArrayList<>();
		List<Integer> ageList = new ArrayList<>();
		List<Integer> dependencyList = new ArrayList<>();
		try {
			if(connection != null) {
				preparedStatement = connection.prepareStatement(query);
				preparedStatement.setInt(1, id);
				
				/* executeQuery: SELECT문만 실행 가능
				 * return: ResultSet object */
				resultSet = preparedStatement.executeQuery();
				
				while(resultSet.next()) {
					ageList.add(resultSet.getInt(1));
					dependencyList.add(resultSet.getInt(2));
				}
				// object closing part
				preparedStatement.close();
				resultSet.close();
				connection.close();
				ageDependency.add(ageList);
				ageDependency.add(dependencyList);
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
		return ageDependency;
	}
}
