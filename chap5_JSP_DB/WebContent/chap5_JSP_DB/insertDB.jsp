<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="service.StudentService, domain.Student"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		StudentService studentService = new StudentService();
		Student student 
			= studentService.insertDB(new Student(request.getParameter("name").trim(),
						0,
						Integer.parseInt(request.getParameter("kor").trim()),
						Integer.parseInt(request.getParameter("eng").trim()),
						Integer.parseInt(request.getParameter("mat").trim())));	
	%>
	<h1>성적 입력 추가 완료</h1><br>
	<table width=285 id=noneBorder>
			<tr id=noneBorder>
				<td align= right id=noneBorder><input type=button value="뒤로가기" OnClick="history.back(-1);"></td>
			</tr>
	</table>
	<p>
	<table border="1" width="285">
		<tr>
			<td width="100" align="center">이름</td>
			<td width="185" align="center"><%=student.getName() %></td>
		</tr>
		<tr>
			<td width="100" align="center">학번</td>
			<td width="185" align="center"><%=student.getStudentId() %></td>
		</tr>
		<tr>
			<td width="100" align="center">국어</td>
			<td width="185" align="center"><%=student.getKor() %></td>
		</tr>
		<tr>
			<td width="100" align="center">영어</td>
			<td width="185" align="center"><%=student.getEng() %></td>
		</tr>
		<tr>
			<td width="100" align="center">수학</td>
			<td width="185" align="center"><%=student.getMat() %></td>
		</tr>
	</table>
</body>
</html>