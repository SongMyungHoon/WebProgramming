<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.time.LocalDate"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!--bootstrap을 사용하기 위한 link-->
	<link rel="stylesheet" 
		  href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
		  integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" 
		  crossorigin="anonymous">
</head>
<body>
	<!--gongji_write.jsp에 Parameter: "key=INSERT, id, title, content" submit-->
	<form method="post" name="insertForm" action="gongji_write.jsp?key=INSERT">
		<table width="650" border="1" cellspacing="0" cellpadding="5" style="margin-left: 20px; margin-top: 20px;">
			<tr>
				<td><b>번호</b></td>
				<td>신규(insert)<input type="hidden" name="id" value="INSERT"></td>
			</tr>
			<tr>
				<td><b>제목</b></td>
				<td><input type="text" name="title" size="70" maxlength="70"></td>
			</tr>
			<tr>
				<td><b>일자</b></td>
				<td><%=LocalDate.now() %></td>
			</tr>
			<tr>
				<td><b>내용</b></td>
				<td><textarea style="width: 500px; height: 250px;" name="content" cols="70" row="600"></textarea></td>
			</tr>
		</table>
		<table width="650">
			<tr>
				<td width="600"></td>
				<td><input type="button" value="취소" OnClick="location.href='gongji_list.jsp'"></td>
				<td><input type="submit" value="쓰기"></td>
			</tr>
		</table>
	</form>
</body>
</html>