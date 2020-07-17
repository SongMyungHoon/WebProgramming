<%@page import="service.VoteService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<!--bootstrap을 사용하기 위한 link-->
	<link rel="stylesheet" 
		  href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
		  integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" 
		  crossorigin="anonymous">
	<title>후보등록-등록결과(삭제)</title>
	<style>
		.tapBox {
			display: inline-block;
			border: 2px solid blue;
			width: 110px;
			text-align: center;
			padding: 5px;
			font-size:20px;
			background-color: #fff;
		}
	</style>
	<%	// A_01.jsp에서 delete를 key로 parameter인 기호번호를 받아온다.
		int id = request.getParameter("delete") == null 
				 ? 0: Integer.parseInt(request.getParameter("delete"));
		VoteService voteService = new VoteService();
	%>
</head>
<body>
	<!--메뉴 이동 부분-->
	<div class="d-flex p-2">
		<span>
			<input type="button" class="tapBox" style="background-color:yellow;" value="후보등록"
				   OnClick="javascript:location.href='./A_01.jsp'">
	    </span>
		<span>
			<input type="button" class="tapBox" value="투표" 
			       OnClick="javascript:location.href='./B_01.jsp'">
	    </span>
		<span>
			<input type="button" class="tapBox" value="개표결과"
				   OnClick="javascript:location.href='./C_01.jsp'">
		</span>
	</div>
	<!--DB에서 후보 정보를 삭제하고 결과를 문자열로 받아 출력한다.-->
	<div class="d-flex pl-4">
	<table>
		<tr border="1px solid black" outline="1px">
			<br>
			<td width="300" align="center"><%=voteService.deleteHubo(id) %></td>
		</tr>
	</table>
	</div>
</body>
</html>