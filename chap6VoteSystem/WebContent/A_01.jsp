<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*, service.*, dao.*, domain.*"%>
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
	<title>후보등록</title>
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
		table {
			border:1px solid black;
		}
		.button {
			display: inline-block;
			padding: 0.3em 1.2em 0.3em 1.2em;
			border-radius: 0.35em;
			letter-spacing: 0.20em;
			text-decoration: none;
			font-weigth: 400;
			font-size: 0.90em;
			color: black;
			background-color: #68dc97;
			border: 2px solid #429E6C;
			outline: 1;
		}
		input {
			border: 2px solid #429E6C;
		}
		input[type="number"] {
			width:50px;
		}
		.inputWidth200 {
			width:200px;
		}
		.tableRowBox {
			border:1px solid black;
			border-collapse: collapse;
		}
	</style>
	<%
		// Service instance 생성
		VoteService voteService = new VoteService();
		// hubo_table의 모든 record 조회
		List<Hubo> huboList = voteService.selectAllHubo();
		// 후보의 기호 자동 지정
		int huboListLastIndex = huboList.size() - 1;
		int nextID = huboList.get(huboListLastIndex).getId() + 1;
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
	<div class="d-flex pl-2">
		<table>
			<!--등록된 모든 후보들의 정보 출력, 
				특정 후보의 삭제 button 클릭 시 DB에서 후보 정보를 삭제하는
				A_02.jsp페이지로 이동, 기호번호를 "delete" parameter로 넘긴다. -->
			<%
				if(huboList.size() > 0) {
					for(Hubo hubo : huboList) {
			%>  
				<form name="deleteForm" method="post" action="A_02.jsp?delete=<%=hubo.getId()%>">
					<tr class="tableRowBox">
						<td width="150">기호번호 : <%=hubo.getId() %></td>
						<td width="300">후보명 : <%=hubo.getName() %></td>
						<td width="50"></td>
						<td widith="150" align="right">
							<input class="button" type="submit" value="삭제">
						</td>
					</tr>
				</form>
			<%
					}
				}
			%>
			<!--추가할 후보의 정보를 입력하고 submit 시 후보등록 결과를 출력하는 A_03.jsp로 이동
				기호번호는 readonly 옵션 지정
			-->
			<form name="insert" method="post" action="A_03.jsp">
				<tr class="tableRowBox">
					<td width="150">기호번호 : <input type="number" name="id" value="<%=nextID %>" readonly /></td>
					<td width="300">후보명 : <input class="inputWidth200" type="text" name="name" /></td>
					<td width="50"></td>
					<td widith="150" align="right"><input class="button" type="submit" value="추가"></td>
				</tr>
			</form>
		</table>
	</div>
</body>
</html>