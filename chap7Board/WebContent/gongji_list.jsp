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
	<style>
		.borderingTD {
			border:1px solid black;
		}
	</style>
	<title>JSP 실습 : CRUD 게시판</title>
	<%
		BoardService boardService = new BoardService();
		// DB 내 모든 post record 조회
		List<Post> postList = boardService.selectAll();
	%>
</head>
<body>
	<p><h1>&nbsp&nbspJSP 실습 : CRUD 게시판</h1>
	<p>
	<table width="600px" border="1px" cellspacing="1">
		<tr class="borderingTD">
			<td class="borderingTD" width="50"><p align="center">번호</p></td>
			<td class="borderingTD" width="500"><p align="center">제목</p></td>
			<td class="borderingTD" width="100"><p align="center">등록일</p></td>
		</tr>
		<%	// DB 내 모든 post에 대하여 반복 수행
			for(Post post : postList) {
				if(postList.size() > 0 && postList != null) {
		%>
		<tr>
			<td class="borderingTD" width="50">
				<p align="center"><%=post.getId() %></p>
			</td>
			<td class="borderingTD" width="500">
				<p align="center">
					<a href="gongji_view.jsp?key=<%=post.getId()%>">
						<%=post.getTitle() %>
					</a>
				</p>
			</td>
			<td class="borderingTD" width="100">
				<p align="center"><%=post.getDate().toLocalDate() %></p>
			</td>
		</tr>
		
		<%		}
			}
		%>
	</table>
	<table width="650">
		<tr>
			<td width="500"></td>
			<td><input type="button" value="신규" OnClick="window.location='gongji_insert.jsp'"></td>
	</table>
</body>
</html>