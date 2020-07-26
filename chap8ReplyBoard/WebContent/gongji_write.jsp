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
		ReBoardService reBoardService = new ReBoardService();
		// gongji_insert.jsp에서 key로 받아온 parameter 값
		String mode = request.getParameter("key") == null ? "null": request.getParameter("key");
		int reCnt = request.getParameter("recnt") == null ? 0 : Integer.parseInt(request.getParameter("recnt"));
		Date date = Date.valueOf(LocalDate.now());
		String resultState = "";
		int postId = 0; // MySQL에서 auto_increment 옵션이 걸려 있으므로 insert에 사용되지 않는 값
		if(mode.equals("INSERT")) { // gongji_insert.jsp에서 요청받은 경우
			if(reCnt > 0) {
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				int rootId = Integer.parseInt(request.getParameter("rootId"));
				int relevel = Integer.parseInt(request.getParameter("relevel"));
				RePost rePost = new RePost(postId, title, date, content, rootId, relevel, reCnt, 0);
				resultState = reBoardService.reInsert(rePost);
				postId = reBoardService.lastInsertedPost().getId();
			} else {
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				RePost insertedPost = new RePost(postId, title, date, content);
				resultState = reBoardService.insert(insertedPost);
				postId = reBoardService.lastInsertedPost().getId();
			}
		} else {	// gongji_update.jsp에서 요청받은 경우
			postId = Integer.parseInt(request.getParameter("id"));
			String updatedTitle = request.getParameter("title");
			String updatedContent = request.getParameter("content");
			RePost updatedPost = new RePost(postId, updatedTitle, date, updatedContent);
			resultState = reBoardService.update(updatedPost);
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