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
        .graph { /* 그래프 그리기를 위한 Style지정 
					그래프가 그려질 전체 영역 부분 */
        	width: 450px;
            padding: 2px;
            font-size:11px;
            text-align: left;
        }
        .graph .bar { /* 그래프 중 bar 부분에 적용될 Style	*/
        	display: inline-block;
            background: red; /* bar color= red*/
            height: 20px;
            float: left;
        }
        .graph .empty { /* bar 외 빈 부분에 적용될 style*/
            height: 20px;
            padding: 5px;
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
				   OnClick="javascript:location.href='registration'">
	    </span>
		<span>
			<input type="button" class="tapBox" value="투표" 
				   OnClick="javascript:location.href='vote'">
	    </span>
		<span>
			<input type="button" class="tapBox" style="background-color:yellow;" value="개표결과"
			       OnClick="javascript:location.href='result'">
		</span>
	</div>
	<p>
	<span style="margin-left: 35px;">후보 별 득표율</span>	<br>
	<div class="d-flex pl-2">
		<table>
			<%
				if(huboList.size() > 0) {
					// DB에 저장된 모든 후보 정보에 대해 반복문 설정
					for(Hubo hubo : huboList) {
						// 득표율(voteRate[%]) = 후보 당 득표 수 / 전체 투표 수
						double voteRate = voteService.voteRateCal(hubo.getId());
						// voteCount = 후보당 득표 수
						int voteCount = voteService.voteCountOne(hubo.getId());
			%>
					<tr class="tableRowBox">
						<td class="tableRowBox" width="150">
							<a href="C_02.jsp?id=<%=hubo.getId()%>">
								&nbsp<%=hubo.getId()%> <%=hubo.getName() %>
							</a>
						</td>
						<td class="tableRowBox" width="500">
							<div class="graph">
								<!--득표율을 width 속성의 % 값으로 지정-->
								<strong class="bar" style="width: <%=voteRate %>%"></strong>
								<!--bar 부분 외의 빈 부분에 득표 수와 득표율을 text로 표시-->
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