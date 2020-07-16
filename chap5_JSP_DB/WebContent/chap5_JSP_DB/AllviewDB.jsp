<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*, service.StudentService, domain.Student"%>
    <!-- 사용할 java file import -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<style> /* table style 지정 */
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
	<table>
		<tr> <!--Table head-->
			<th>이름</th>
			<th>학번</th>
			<th>국어</th>
			<th>영어</th>
			<th>수학</th>
		</tr>
		<%	
			StudentService studentService = new StudentService();
			// table의 모든 데이터 가져와서 studentList에 저장
			List<Student> studentList = studentService.selectAll();
			// studentList의 모든 element에 대해 for loop 수행
			for(Student student : studentList) {
				out.println("<tr>");
				out.println("<td align='center'>");
				/* 학번을 request 객체의 parameter로 넘겨주고 
				 * 해당 학번의 정보를 보여주는 OneViewDB.jsp로 페이지 이동*/
				out.println("<a href=\"./OneViewDB.jsp?studentId="+student.getStudentId() +"\">");
				out.println(student.getName() + "</a>");
				out.println("</td><td align='center'>");
				out.println(student.getStudentId());
				out.println("</td><td align='center'>");
				out.println(student.getKor());
				out.println("</td><td align='center'>");
				out.println(student.getEng());
				out.println("</td><td align='center'>");
				out.println(student.getMat());
				out.println("</td></tr>");
			}
		%>
	</table>
</body>
</html>