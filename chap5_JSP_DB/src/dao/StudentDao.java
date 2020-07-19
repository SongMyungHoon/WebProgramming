package dao;

import java.sql.*;
import java.util.*;

import domain.Student;

public class StudentDao {
	
	// Dao 클래스에서 사용될 공유 connection 객체
	private static Connection connection;
	
	// singleton pattern applied default constructor
	private StudentDao() {}	
	
	// declaring Lazy-Holder(중첩 클래스)
	private static class LazyHolder {
		/* static: 클래스 로딩 시점에 한번만 호출됨
		 * final: 값이 다시 할당되지 않음 */
		private static final StudentDao instance = new StudentDao();
	}
	
	// getInstance method 호출 시 LazyHolder 호출
	public static StudentDao getInstance() {
		return LazyHolder.instance;
	}
	
	// database(MySQL)과 연동시켜 관련 정보를 static Connection 객체에 저장
	public static void dbConnect() {
		final String id = "root";
		final String password = "qortjf90";
		final String accessURL = "jdbc:mysql://localhost:3306/"
				+ "?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Seoul"
				+ "&allowPublicKeyRetrieval=true&useSSL=false";
		final String dbName = "koposw26";
		
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
			
	/* "C"reate
	 * table 생성 method로 작업 결과를 String으로 return한다. */
	public String createTable() {
		dbConnect(); // database Connection 생성
		Statement statement = null;
		StringBuilder stringBuilder = new StringBuilder();
		// examtable creation query
		String query = stringBuilder.append("create table examtable(")
						.append("name varchar(20), ")
						.append("studentId int not null primary key, ")
						.append("kor int, ")
						.append("eng int, ")
						.append("mat int);")
						.toString();
		try {
			if(connection != null) {
				statement = connection.createStatement();
				if(statement != null) {
					/* execute method: 모든 유형의 SQL문장 사용 가능
					 * return boolean */
					statement.execute(query);
					statement.close();
				}
				// object closing part
				connection.close();
			} else {
				System.out.println("Connection isNull");
				return "Connection isNull";
			}
		} catch (SQLException e) {
			System.out.println("table 생성 실패");
			e.printStackTrace();
			return "테이블 생성 실패";
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
				return "Closing error";
			}
		}
		return "테이블 생성 OK";
	}
	
	/* "R"ead
	 * select query를 수행하는 method
	 * parameter로 받는 studentId에 해당하는 student의 정보를 domain.Student 객체로 return */
	public Student selectOne(int studentId) {
		dbConnect(); // database Connection 생성
		PreparedStatement preparedStatement;
		ResultSet resultSet;
		// SELECT query문 
		String query = "select * from examtable where studentId = ?;";
		Student student = null;
		try {
			if(connection != null) {
				// studentId를 조건절에 대입해야하므로 PrepareStatment 사용
				preparedStatement = connection.prepareStatement(query);
				preparedStatement.setInt(1, studentId);
				/* executeQuery: SELECT문만 실행 가능
				 * return: ResultSet object */
				resultSet = preparedStatement.executeQuery();
				
				while(resultSet.next()) {
					// query 수행 결과 return 받은 ResultSet으로 Student 객체 생성
					student = new Student(resultSet.getString("name")
										, resultSet.getInt("studentId")
										, resultSet.getInt("kor")
										, resultSet.getInt("eng")
										, resultSet.getInt("mat"));
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
		return student;	// query 수행 결과 생성한 Student object return
	}
	
	/* "R"ead
	 * SELECT query를 수행하여 Table의 모든 record를 출력하는 method 
	 * return: Student를 data object로 하는 List */
	public List<Student> selectAll() {
		dbConnect();
		Statement statement = null;
		ResultSet resultSet = null;
		String query = "select * from examtable;";
		
		List<Student> studentList = new ArrayList<>();
		try {
			if(connection != null) {
				statement = connection.createStatement();
				/* executeQuery: SELECT문만 실행 가능
				 * return: ResultSet object */
				resultSet = statement.executeQuery(query);
				
				while(resultSet.next()) {
					studentList.add(new Student(resultSet.getString("name")
												, resultSet.getInt("studentId")
												, resultSet.getInt("kor")
												, resultSet.getInt("eng")
												, resultSet.getInt("mat")));
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
		return studentList;
	}
	
	/* "R"ead
	 * SELECT query를 수행하여 record의 학번 정보를 불러오는 method 
	 * return: StudentId를 data object로 하는 List */
	public List<Integer> selectStudentId() {
		dbConnect();
		Statement statement = null;
		ResultSet resultSet = null;
		String query = "select studentId from examtable;";
		
		List<Integer> studentIdList = new ArrayList<>();
		try {
			if(connection != null) {
				statement = connection.createStatement();
				/* executeQuery: SELECT문만 실행 가능
				 * return: ResultSet object */
				resultSet = statement.executeQuery(query);
				
				while(resultSet.next()) {
					studentIdList.add(resultSet.getInt("studentId"));
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
		return studentIdList;
	}
		
	/* "U"pdate
	 * data를 database에 insert하는 method 
	 * query 수행 결과를 String으로 return */
	public String insert(Student student) {
		dbConnect(); // database Connection 생성
		PreparedStatement preparedStatement = null;
		String query = "insert into examtable value (?, ?, ?, ?, ?);";
		try {
			if(connection != null) {
				// 입력할 data가 미정이므로 PrepareStatement 객체 사용
				preparedStatement = connection.prepareStatement(query);
				preparedStatement.setString(1, student.getName());
				preparedStatement.setInt(2, student.getStudentId());
				preparedStatement.setInt(3, student.getKor());
				preparedStatement.setInt(4, student.getEng());
				preparedStatement.setInt(5, student.getMat());
				/* executeUpdate method
				 * : INSERT, UPDATE, DELETE같은 DML sql이나 반환값이 없는 DDL문 수행가능
				 * return: (int) affectedRows count */
				preparedStatement.executeUpdate();
				
				// object closing part
				preparedStatement.close();
				connection.close();
			} else {
				System.out.println("Connection isNull");
				return "Connection isNull";
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return "데이터 입력 실패: SQLException";
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
				return "Closing Error";
			}
		}
		return student.getName() + "의 데이터 입력 완료";
	}

	/**Student를 입력 받아 update query를 수행해
	 * DB 내 record를 수정하는 method
	 * @param student
	 * @return SQL 실행이 실패 시 false, 성공 시 true return
	 */
	public boolean update(Student student) {
		dbConnect(); // database Connection 생성
		PreparedStatement preparedStatement = null;
		String query = "update examtable set name = ?, studentId = ?, "
				+ "kor = ?, eng = ?, mat = ? where studentId = ?;";
		try {
			if(connection != null) {
				// 입력할 data가 미정이므로 PrepareStatement 객체 사용
				preparedStatement = connection.prepareStatement(query);
				preparedStatement.setString(1, student.getName());
				preparedStatement.setInt(2, student.getStudentId());
				preparedStatement.setInt(3, student.getKor());
				preparedStatement.setInt(4, student.getEng());
				preparedStatement.setInt(5, student.getMat());
				preparedStatement.setInt(6, student.getStudentId());
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
	
	/* "D"elete 
	 * table을 drop하는 method로 query 수행 결과를 String으로 return */
	public String dropTable() {
		dbConnect(); // database Connection 생성
		Statement statement = null;
		String query = "drop table examtable;";
		
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
				return "Connection isNull";
			}
		} catch (SQLException e) {
			System.out.println("table 삭제 실패");
			e.printStackTrace();
			return "테이블 삭제 실패";
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
				return "Closing error";
			}
		}
		return "테이블 삭제 OK";
	}

	/**Student를 입력 받아 delete query를 수행해
	 * DB 내 record를 삭제하는 method
	 * @param student
	 * @return SQL 실행이 실패 시 false, 성공 시 true return
	 */
	public boolean delete(Student student) {
		dbConnect(); // database Connection 생성
		PreparedStatement preparedStatement = null;
		String query = "delete from examtable where studentId = ?;";
		try {
			if(connection != null) {
				// 입력할 data가 미정이므로 PrepareStatement 객체 사용
				preparedStatement = connection.prepareStatement(query);
				preparedStatement.setInt(1, student.getStudentId());
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
}