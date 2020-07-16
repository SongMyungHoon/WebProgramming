<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<SCRIPT LANGUAGE="JavaScript">
		<!--
		function submitForm(mode) {
			if(mode == "write") {
				fm.action = "gongji_write.jsp";
			} else if(mode == "delete") {
				fm.action = "gongji_delete.jsp";
			}
			fm.submit();
		}
		//-->
	</SCRIPT>
</head>
<body>
	<FORM METHOD=POST name='fm'>
		<table width=650 border=1 cellspacing=0 cellpadding=5>
			<tr>
				<td><b>번호</b></td>
				<td><input type=text name=id size=70 value=1 readonly></td>
			</tr>
			<tr>
				<td><b>제목</b></td>
				<td><input type=text name=title size=70 maxlength=70 value="공지사항1"></td>
			</tr>
			<tr>
				<td><b>일자</b></td>
				<td>2012-01-14</td>
			</tr>
			<tr>
				<td><b>내용</b></td>
				<td><textarea style='width:500px; height=250px;' name=content cols=70 row=600>공지사항내용1</textarea></td>
			</tr>
		</table>
		<table width=650>
			<tr>
				<td width=600></td>
				<td><input type=button value="취소" OnClick="location.href='gongji_list.jsp'"></td>
				<td><input type=button value="쓰기" OnClick="submitForm('write')"></td>
				<td><input type=button value="삭제" OnClick="submitForm('delete')"></td>
			</tr>
		</table>
	</FORM>
</body>
</html>