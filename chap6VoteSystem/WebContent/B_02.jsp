<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*, service.*, dao.*, domain.*"%>
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
	<title>투표-투표 결과</title>
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
	<%	// B_01.jsp에서 넘겨받은 기호번호와 투표자 연령대로 Tupyo instance 생성
		int tupyoID = Integer.parseInt(request.getParameter("id").trim());
		int age = Integer.parseInt(request.getParameter("age").trim());
		VoteService voteService = new VoteService();
		Tupyo tupyo = new Tupyo(tupyoID, age);
	%>
</head>
<body>
	<!--메뉴 이동 부분-->
	<div class="d-flex p-2">
		<span>
			<input type="button" class="tapBox" value="후보등록"
				   OnClick="javascript:location.href='./A_01.jsp'">
	    </span>
		<span>
			<input type="button" class="tapBox" style="background-color:yellow;" value="투표" 
				   OnClick="javascript:location.href='./B_01.jsp'">
	    </span>
		<span>
			<input type="button" class="tapBox" value="개표결과"
			       OnClick="javascript:location.href='./C_01.jsp'">
		</span>
	</div>
	<div class="d-flex pl-4">
	<table>
		<tr>
			<br>
			<!--생성한 Tupyo instance로 DB에 투표 결과 저장-->
			<td width="300" align="center"><%=voteService.insertTupyo(tupyo) %></td>
		</tr>
	</table>
	</div>
</body>
</html>