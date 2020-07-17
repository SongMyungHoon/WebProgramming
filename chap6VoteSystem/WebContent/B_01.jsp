<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*, service.*, dao.*, domain.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>투표-투표</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
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
		.tableRowBox {
			border:1px solid black;
			padding: 2px;
			height: 50px;
		}
		tr {
			height: 50px;
		}
	</style>
	<%
		int id = request.getParameter("delete") == null ? 0: Integer.parseInt(request.getParameter("delete"));
		VoteService voteService = new VoteService();
		List<Hubo> huboList = voteService.selectAllHubo();
		request.setAttribute("huboList", huboList);
	%>
</head>
<body>
	<div class="d-flex p-2">
		<span>
			<input type="button" class="tapBox" value="후보등록"
					     OnClick="javascript:location.href='./A_01.jsp'">
	    </span>
		<span>
			<input type="button" class="tapBox" style="background-color:yellow;" value="투표" 
				   OnClick="javascript:location.href='./B_01.jsp'">
	    </span>
		<span><input type="button" class="tapBox" value="개표결과"
						 OnClick="javascript:location.href='./C_01.jsp'">
		</span>
	</div>
	<p>
	<div class="d-flex pl-2">
		<table>
			<form class="form-inline" name="vote" method="post" action="B_02.jsp">
				<tr class="tableRowBox">	
					<td width="200" align="center">
						<select name="id" style="height:auto;min-height:30px;">
							<option value=""></option>
							<%for(Hubo hubo: huboList){%>
								<option value="<%=hubo.getId() %>"><%=hubo.getId() %>번 <%=hubo.getName() %></option>
							<%}%>
						</select>
					</td>
					<td width="100">
						<select name="age" style="margin-left:40px;height:auto;min-height:30px;">
							<option value=""></option>
							<%for(int age = 1; age < 10; age++) {%>
								<option value="<%=age %>"><%=age %>0대</option>
							<%}%>
						</select>
					</td>
					<td width="100"></td>
					<td width="150" align="right" style="padding-right: 0.7em;">
						<input class="button" type="submit" id="marginLeft" value="투표하기">
					</td>
				</tr>
			</form>
		</table>
	</div>
</body>
</html>