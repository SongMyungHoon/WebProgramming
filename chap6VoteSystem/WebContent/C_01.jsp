<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*, service.*, dao.*, domain.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
	<title>개표결과-득표율</title>
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
		.tableRowBox {
			border:1px solid black;
			border-collapse: collapse;
		}
        .graph {
        	width: 450px;
            padding: 2px;
            font-size:11px;
            text-align: left;
        }
        .graph .bar { 
        	display: inline-block;
            background: red;
            height: 20px;
            float: left;
        }
        .graph .empty { 
            height: 20px;
            padding: 5px;
        }
	</style>
	<%
		VoteService voteService = new VoteService();
		List<Hubo> huboList = voteService.selectAllHubo();
	%>
</head>
<body>
	<div class="d-flex p-2">
		<span>
			<input type="button" class="tapBox" value="후보등록"
					     OnClick="javascript:location.href='./A_01.jsp'">
	    </span>
		<span>
			<input type="button" class="tapBox" value="투표" OnClick="javascript:location.href='./B_01.jsp'">
	    </span>
		<span><input type="button" class="tapBox" style="background-color:yellow;" value="개표결과"
						 OnClick="javascript:location.href='./C_01.jsp'">
		</span>
	</div>
	<p>
	<span style="margin-left: 35px;">후보 별 득표율</span>	<br>
	<div class="d-flex pl-2">
		<table>
			<%
				if(huboList.size() > 0) {
					for(Hubo hubo : huboList) {
						double voteRate = voteService.voteRateCal(hubo.getId());
						int voteCount = voteService.voteCountOne(hubo.getId());
			%>
					<tr class="tableRowBox">
						<td class="tableRowBox" width="150">
							<a href="C_02.jsp?id=<%=hubo.getId()%>">&nbsp<%=hubo.getId()%> <%=hubo.getName() %></a>
						</td>
						<td class="tableRowBox" width="500">
							<div class="graph">
								<strong class="bar" style="width: <%=voteRate %>%"></strong>
								<strong class="empty"><%=voteCount %> (<%=voteRate%>%)</strong>
							</div>
						</td>
					</tr>
			<%
					}
				}
			%>
		</table>
	</div>
</body>
</html>