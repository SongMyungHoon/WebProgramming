<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="service.*, domain.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<SCRIPT LANGUAGE="JavaScript">
		<!--submit을 분기하기 위한 function-->
		function submitForm(mode) {
 			if(mode == "WRITE") {
				updateForm.action = "gongji_write.jsp";
			} else if(mode == "DELETE") {
				updateForm.action = "gongji_delete.jsp";
			}
			updateForm.submit();
		}
	</SCRIPT>
	<!--bootstrap을 사용하기 위한 link-->
	<link rel="stylesheet" 
		  href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
		  integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" 
		  crossorigin="anonymous">
	<%
		ReBoardService reBoardService = new ReBoardService();
		int postId = Integer.parseInt(request.getParameter("key"));
		RePost post = reBoardService.selectOne(postId);
	%>
</head>
<body>
	<form method="post" name="updateForm">
		<table width="650" cellspacing="0" cellpadding="5" style="margin-left: 20px; margin-top: 20px;">
			<tr>
				<td><b>번호</b></td>
				<td><input type="text" name="id" size="70" maxlength="70" value="<%=post.getId() %>" readonly></td>
			</tr>
			<tr>
				<td><b>제목</b></td>
				<td><input type="text" name="title" size="70" maxlength="70" value="<%=post.getTitle()%>"></td>
			</tr>
			<tr>
				<td><b>일자</b></td>
				<td><%=post.getDate().toLocalDate() %></td>
			</tr>
			<tr>
				<td><b>내용</b></td>
				<td><textarea style="width: 500px; height: 250px;" name="content" cols="70" row="600"><%=post.getContent() %></textarea>
				</td>
			</tr>
		</table>
		<table width="650">
			<tr>
				<td width="600"></td>
				<td><input type="button" value="취소" OnClick="location.href='gongji_list.jsp'"></td>
				<td><input type="button" value="쓰기" OnClick="submitForm('WRITE')"></td>
				<td><input type="button" value="삭제" OnClick="submitForm('DELETE')"></td>
			</tr>
		</table>
	</form>
</body>
</html>