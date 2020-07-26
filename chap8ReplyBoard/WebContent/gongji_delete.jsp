<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="service.*, domain.*"%>
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
			// gongji_update.jsp에서 key: id로 post의 id 값을 parameter로 받아온다.
			int postId = Integer.parseInt(request.getParameter("id"));
	%>
</head>
<body>
	<SCRIPT LANGUAGE="JavaScript">
		window.alert("<%=reBoardService.delete(postId) %>");
		location.href="gongji_list.jsp";
	</SCRIPT>
</body>
</html>