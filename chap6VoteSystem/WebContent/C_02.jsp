<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*, service.*, dao.*, domain.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
	<title>개표결과-성향분석</title>
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
		int id = Integer.parseInt(request.getParameter("id").trim());
		List<List<Integer>> ageTendency = voteService.ageTendency(id);
		List<Integer> ageList = ageTendency.get(0);
		List<Integer> voteCountList = ageTendency.get(1);
		List<Double> tendencyRateList = voteService.tendencyRateList(id);

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
			for(int index = 0; index < ageList.size(); index++) {
		%>
			<tr class="tableRowBox">
				<td class="tableRowBox" width="150">
					&nbsp<%=ageList.get(index)%>0대 
				</td>
				<td class="tableRowBox" width="500">
					<div class="graph">
						<strong class="bar" style="width: <%=tendencyRateList.get(index)%>%;"></strong>
						<strong class="empty"><%=voteCountList.get(index) %> (<%=tendencyRateList.get(index)%>%)</strong>
					</div>
				</td>
			</tr>
		<%
			}
		%>
		</table>
	</div>
</body>
</html>