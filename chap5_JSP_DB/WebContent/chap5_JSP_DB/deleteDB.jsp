<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, java.io.* ,service.*, domain.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
	<!--사용할 java file import-->
<!DOCTYPE html>
<html>
<head>
	<style> /* table style 지정 */
		   table {
               width: 100%;
               border: 1px solid #444444;
           }
           th, td {
               border: 1px solid #444444;
           }
    </style>
 	<%
		int studentId = Integer.parseInt(request.getParameter("iD"));
		StudentService studentService = new StudentService();
		// 해당 학번에 대한 학생 정보를 DB에서 불러와 Student instance 생성
		Student student = studentService.selectOne(studentId);
		studentService.delete(student);	// DB에서 해당 학번의 데이터 삭제
		// table의 모든 데이터 가져와서 studentList에 저장
		List<Student> studentList = studentService.selectAll();
	%>
</head>
<body>
	
	<table>
		<tr> <!--Table head-->
			<th>이름</th>
			<th>학번</th>
			<th>국어</th>
			<th>영어</th>
			<th>수학</th>
		</tr>
		<%	/* 쿼리 수행 후 DB의 데이터를 모두 출력
			 * studentList의 모든 element에 대해 for loop 수행 */
			for(Student record : studentList) {
				out.println("<tr>");
				out.println("<td align='center'>");
				/* 학번을 request 객체의 parameter로 넘겨주고 
				 * 해당 학번의 정보를 보여주는 OneViewDB.jsp로 페이지 이동*/
				out.println("<a href=\"./OneViewDB.jsp?studentId="+ record.getStudentId() +"\">");
				out.println(record.getName() + "</a>");
				out.println("</td><td align='center'>");
				out.println(record.getStudentId());
				out.println("</td><td align='center'>");
				out.println(record.getKor());
				out.println("</td><td align='center'>");
				out.println(record.getEng());
				out.println("</td><td align='center'>");
				out.println(record.getMat());
				out.println("</td></tr>");
			}
		%>
	</table>
</body>
</html>