<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="service.*, domain.*, java.sql.Date, java.time.LocalDate"%>
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
	<%
		BoardService boardService = new BoardService();
		String mode = request.getParameter("key") == null ? "null": request.getParameter("key");
		Date date = Date.valueOf(LocalDate.now());
		String resultState = "";
		int postId = 0; // MySQL에서 auto_increment 옵션이 걸려 있으므로 insert에 사용되지 않는 값
		
		if(mode.equals("INSERT")) {
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			Post insertedPost = new Post(postId, title, date, content);
			resultState = boardService.insert(insertedPost);
		} else {
			postId = Integer.parseInt(request.getParameter("id"));
			String updatedTitle = request.getParameter("title");
			String updatedContent = request.getParameter("content");
			Post updatedPost = new Post(postId, updatedTitle, date, updatedContent);
			resultState = boardService.update(updatedPost);
		}
	%>
</head>
<body>
	<SCRIPT LANGUAGE="JavaScript">
		window.alert("<%=resultState %>");
		location.href="gongji_view.jsp?key=<%=postId%>";
	</SCRIPT>
</body>
</html>