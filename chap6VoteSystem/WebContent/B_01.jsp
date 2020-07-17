<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*, service.*, dao.*, domain.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>투표-투표</title>
	<!--bootstrap을 사용하기 위한 link-->
	<link rel="stylesheet" 
		  href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
		  integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" 
		  crossorigin="anonymous">
	<style>
		.tapBox {
			display: inline-block;
			border: 2px solid blue;
			width: 110px;
			text-align: center;
			padding: 5px;
			font-size:20px;
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
	<%	// VoteService instance 생성
		VoteService voteService = new VoteService();
		// DB에 저장된 모든 후보 정보 조회
		List<Hubo> huboList = voteService.selectAllHubo();
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
	<p>
	<!--ComboBox 형태 투표 화면 부분-->
	<div class="d-flex pl-2">
		<table>
			<!--submit 후 key="id, age"로 B_02.jsp에 기호, 투표자 연령대를 parameter로 넘김-->
			<form class="form-inline" name="vote" method="post" action="B_02.jsp">
				<tr class="tableRowBox">	
					<td width="200" align="center">
						<select name="id" style="height:auto;min-height:30px;">
							<option value=""></option>
							<!--전체 후보 목록 출력-->
							<%for(Hubo hubo: huboList){%>
								<option value="<%=hubo.getId() %>"><%=hubo.getId() %>번 <%=hubo.getName() %></option>
							<%}%>
						</select>
					</td>
					<td width="100">
						<select name="age" style="margin-left:40px;height:auto;min-height:30px;">
							<option value=""></option>
							<!--투표자 연령 선택 입력-->
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