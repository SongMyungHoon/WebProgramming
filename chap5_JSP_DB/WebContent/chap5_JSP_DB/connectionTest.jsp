<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>조회</h1>
<%
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.110:33060"
			+ "/koposw26?serverTimezone=UTC","root","qortjf90");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("show databases;");
%>
<table cellspacing=1 width=600 border=1>
<%
	while(rset.next()) {
		out.println("<tr>");
		out.println("<td width=50><p align=center>" + rset.getString(1) + "</p></td>");
		out.println("</tr>");
	}
	rset.close();
	stmt.close();
	conn.close();
%>
</table>
</body>
</html>