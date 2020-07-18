<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*, service.*, domain.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<SCRIPT LANGUAGE="JavaScript"></SCRIPT>
	<!--bootstrap을 사용하기 위한 link-->
	<link rel="stylesheet" 
		  href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
		  integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" 
		  crossorigin="anonymous">
</head>
<body>
	<form method="post" name="oneViewForm" action="gongji_write.jsp?key=INSERT">
		<table width="650" border="1" cellspacing="0" cellpadding="5">
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
				<td><textarea style="width: 500px; height: 250px;" name="content" cols="70" row="600"></</textarea></td>
			</tr>
		</table>
	</form>
</body>
</html>