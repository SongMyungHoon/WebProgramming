<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>후보등록 A_01.jsp</title>
	<style>
		.tapBox {
			display: inline-block;
			border: 2px solid blue;
			width: 90px;
			text-align: center;
			padding: 5px;
			font-size:20px;
		}
		table {
			border:1px solid black;
		}
		.button {
			display: inline-block;
			padding: 0.4em 1.5em 0.4em 1.5em;
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
	</style>
</head>
<body>
	<div>
		<span class="tapBox" style="background-color: yellow"><b>후보등록</b></span>
		<span class="tapBox"><b>투표</b></span>
		<span class="tapBox"><b>개표결과</b></span>
	</div>
	<table>
		<tr border="1px solid black" outline="1px">
			<td width="130">기호번호 : 1</td>
			<td width="130">후보명 : 김일돌</td>
			<td width="150"></td>
			<td widith="150" align="right"><input class="button" type="submit" value="삭제" OnClick="javascript:" ></td>
		</tr>
	</table>
</body>
</html>