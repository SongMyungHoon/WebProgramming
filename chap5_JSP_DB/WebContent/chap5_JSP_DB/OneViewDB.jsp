<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*, service.StudentService, domain.Student"%>
	<!--사용할 java file import-->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<style> /* table style 설정 */
           table {
               width: 100%;
               border: 1px solid #444444;
           }
           th, td {
               border: 1px solid #444444;
           }
    </style>
</head>
<body>
	<h4>조회</h4>
	<% 	
		StudentService studentService = new StudentService();
		// AllViewDB.jsp 에서 URL로 넘겨받은 studentId 값 null 여부 확인 후 int type studentId에 저장
		int studentId = request.getParameter("studentId") == null 
						? 0 : Integer.parseInt(request.getParameter("studentId"));
		// studentId == null 인 경우 error 문구 출력
		if(studentId == 0) {
			out.print("studentId == null");
		} else {
			// studentId != null 이라면, studentId에 해당하는 student 정보 DB에서 받아 옴
			Student student = studentService.selectOne(studentId);
	%>
	<table>
		<tr> <!--table head-->
			<th>이름</th>
			<th>학번</th>
			<th>국어</th>
			<th>영어</th>
			<th>수학</th>
		</tr>
		<tr> <!--student 정보 출력-->
			<td align='center'>
				<%=student.getName() %>
			</td>
			<td align='center'>
				<%=student.getStudentId() %>
			</td>
			<td align='center'>
				<%=student.getKor() %>
			</td>
			<td align='center'>
				<%=student.getEng() %>
			</td>
			<td align='center'>
				<%=student.getMat() %>
			</td>
		</tr>
	</table>
	<%} %>
</body>
</html>