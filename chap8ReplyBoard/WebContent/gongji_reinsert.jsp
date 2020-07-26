<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.time.LocalDate, service.*, domain.*, java.sql.Date"%>
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
	<%
		ReBoardService reBoardService = new ReBoardService();
			Date date = Date.valueOf(LocalDate.now());
			int rootId = Integer.parseInt(request.getParameter("rootId"));
			int reLevel = Integer.parseInt(request.getParameter("relevel")) + 1;
			int reCnt = reBoardService.selectReCnt(rootId) + 1;
			int viewCnt = 0;
	%>
</head>
<body>
	<!--gongji_write.jsp에 Parameter: "key=INSERT, id, title, content" submit-->
	<form method="post" name="reInsertForm" action="gongji_write.jsp?key=INSERT">
		<table width="650" border="1" cellspacing="0" cellpadding="5" style="margin-left: 20px; margin-top: 20px;">
			<tr>
				<td><b>번호</b></td>
				<td>
					댓글<input type="text" name="id" value="INSERT" readonly>
				</td>
			</tr>
			<tr>
				<td><b>제목</b></td>
				<td>
					<input type="text" name="title" size="70" maxlength="70">
				</td>
			</tr>
			<tr>
				<td><b>일자</b></td>
				<td>
					<%=LocalDate.now() %>
				</td>
			</tr>
			<tr>
				<td><b>내용</b></td>
				<td>
					<textarea style="width: 500px; height: 250px;" name="content" cols="70" row="600"></textarea>
				</td>
			</tr>
			<tr>
				<td><b>원글</b></td>
				<td>
					<input type="text" name="rootId" value="<%=rootId %>" readonly>
				</td>
			</tr>
			<tr>
				<td><b>댓글수준</b></td>
				<td>
					<input type="text" name="relevel" value="<%=reLevel %>" readonly>
					<span style="margin-left: 50px">댓글내 순서 </span><input type="text" name="recnt" value="<%=reCnt %>" readonly>
				</td>
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