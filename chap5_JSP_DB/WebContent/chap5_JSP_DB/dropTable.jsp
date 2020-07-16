<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="service.StudentService"%>
    <!-- 사용할 java file import -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
</head>
<body>
	<%
		StudentService studentService = new StudentService();
		String status = studentService.dropTable();
	%>
	<!--dropTable service 작동 결과 출력-->
	<h4><%=status %></h4>
</body>
</html>