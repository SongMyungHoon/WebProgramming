<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="service.*, domain.*"%>
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
	<%
		ReBoardService reBoardService = new ReBoardService();
		int postId = Integer.parseInt(request.getParameter("key"));
		RePost post = reBoardService.selectOne(postId);
		int viewCnt = post.getViewcnt() + 1; // 조회수 1 증가
		post.setViewcnt(viewCnt);			// post의 조회수 1증가한 값 set
		reBoardService.viewCntUpdate(post);		// 조회수 증가분 Database에 저장
		int rootId = post.getRootId();
	%>
</head>
<body>
	<form method="post" name="viewForm" action="gongji_reinsert.jsp">
		<table width="650px" border="1px" cellspacing="0" cellpadding="5" style="margin-left: 20px; margin-top: 20px;">
			<tr>
				<td><b>번호</b></td>
				<td>
					<%=post.getId() %>
					<input type="hidden" name="postId" value="<%=post.getId() %>">
				</td>
			</tr>
			<tr>
				<td><b>제목</b></td>
				<td><%=post.getTitle() %></td>
			</tr>
			<tr>
				<td><b>일자</b></td>
				<td><%=post.getDate().toLocalDate() %></td>
			</tr>
			<tr>
				<td><b>조회수</b></td>
				<td><%=post.getViewcnt() %></td>
			</tr>
			<tr>
				<td><b>내용</b></td>
				<td><%=post.getContent() %></td>
			</tr>
			<tr>
				<td><b>원글</b></td>
				<td>
					<%=rootId %>
					<input type="hidden" name="rootId" value="<%=post.getRelevel() %>">
				</td>
			</tr>
			<tr>
				<td><b>댓글수준</b></td>
				<td>
					<%=post.getRelevel() %>
					<input type="hidden" name="relevel" value="<%=post.getRelevel() %>">
				</td>
			</tr>
		</table>
		<table width="650">
			<tr>
				<td width="500"></td>
				<td>
					<input type="button" value="목록" OnClick="location.href='gongji_list.jsp'">
				</td>
				<!--gongji_update.jsp에 parameter: "key = postId" submit-->
				<td>
					<input type="button" value="수정" OnClick="location.href='gongji_update.jsp?key=<%=post.getId()%>'">
				</td>
				<td>
					<input type="button" value="삭제" OnClick="location.href='gongji_delete.jsp?id=<%=post.getId()%>'">
				</td>
				<td>
					<input type="submit" value="댓글">
				</td>
		</table>
	</form>
</body>
</html>