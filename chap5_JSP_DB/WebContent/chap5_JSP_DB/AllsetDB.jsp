<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="service.StudentService, domain.Student"%>
    <!-- 사용할 java file import -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	
</head>
<body>
	<h3>실습 데이터 입력</h3>
	<%
		StudentService studentService = new StudentService();
		// insert할 Student 객체 생성하여 Array에 담는다.
		Student[] studentArray = {new Student("나연",209901,95,100,95),
								new Student("정연",209902,95,95,95),
								new Student("모모",209903,100,100,100),
								new Student("사나",209904,100,95,90),
								new Student("지효",209905,80,100,70),
								new Student("미나",209906,100,100,70),
								new Student("다현",209907,70,70,70),
								new Student("채영",209908,80,75,72),
								new Student("쯔위",209909,79,79,82)};
		// studentArray의 모든 element에 대해 for문 수행
		for(Student student : studentArray) {
			String status = studentService.insert(student);
			out.println(status + "<br>");
		}
	%>		
</body>
</html>