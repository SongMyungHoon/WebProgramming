<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"    import="java.io.*, javax.sql.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP - DB Connection Test</title>
</head>
<body>
	<%
		String id = "root";
		String password = "qortjf90";
		String accessURL = "jdbc:mysql://localhost:3306/"
				+ "?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Seoul"
				+ "&allowPublicKeyRetrieval=true&useSSL=false";
		String dbName = "koposw26";
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		Connection connection = DriverManager.getConnection(accessURL, id, password);
		connection.setCatalog(dbName);
		Statement stmt = connection.createStatement();
		ResultSet rset = stmt.executeQuery("show databases;");
		while(rset.next()) {
			out.println(rset.getString(1)+"<br>");
		}
		rset.close();
		stmt.close();
		connection.close();		
	%>
</body>
</html>