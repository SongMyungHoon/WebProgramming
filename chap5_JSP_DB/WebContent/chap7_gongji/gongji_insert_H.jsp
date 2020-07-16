<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script Language="JavaScript">
<!--
function submitForm(mode) {
	fm.action = "gongji_write.jsp?key=INSERT";
	fm.submit();
}
//-->
</script>
</head>
<body>
<FORM METHOD=POST name='fm'>
	<table width=650 border=1 cellspacing=0 cellpadding=5>
		<tr>
			<td><b>번호</b></td>
			<td>신규(insert)<input type=hidden name=id value='INSERT'></td>
		</tr>
		<tr>
			<td><b>제목</b></td>
			<td><input type=text name=title size=70 maxlength=70></td>
		</tr>
		<tr>
			<td><b>일자</b></td>
			<td>2018-03-25</td>
		</tr>
		<tr>
			<td><b>내용</b></td>
			<td><textarea style='width:500 px; height: 250px;' name=content cols=70 row=600></textarea></td>
		</tr>
	</table>
	<table width=650>
		<tr>
			<td width=600></td>
			<td><input type=button value="취소" OnClick="location.href='gongji_list.jsp'"></td>
			<td><input type=button value="쓰기" OnClick="submitForm('write')"></td>
		</tr>
	</table>
</FORM>
	
</body>
</html>