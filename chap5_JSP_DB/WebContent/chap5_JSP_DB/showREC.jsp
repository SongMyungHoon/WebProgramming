<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*, java.io.* ,service.*, domain.*"%>
	<!--사용할 java file import-->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<style> /* table style 지정 */
           th, td {
               border: 1px solid #444444;
           }
           #noneBorder {
	       		border-style: none;
           }
    </style>
    <%
    	int studentId = Integer.parseInt(request.getParameter("studentId"));;
    	StudentService studentService = new StudentService();
   	%>
    <script>
		function isSpecial(data) {
			var pattern_spc = /[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\#$%&\\\=\(\'\"]/gi;
			if(pattern_spc.test(data)) {
				return true
			} else {
				return false
			}
		}
		function isNumeric(data) {
	    	var pattern_num = /[0-9]/;	// 숫자 
	    	if(pattern_num.test(data)){
	    		return true
	    	} else {
	    		return false
	    	}
		}
		function selectFormCheck() {
			if(document.selectForm.studentId.value.length == 0) {
				window.alert("값을 입력해주세요!");
				document.selectForm.studentId.focus();
			} else if(!isNumeric(document.selectForm.studentId.value)) {
				window.alert("학번은 숫자로만 구성되어 있습니다..");
				document.selectForm.studentId.focus();
			} else {
				return true;				
			}
			return false;
		}
    	function updateDeleteCheck() {
        	// 이름 체크
       		if(document.updateDelete.name.value.length == 0 
       	       		|| document.updateDelete.name.value == null
       	       		|| document.updateDelete.name.value == "") {
   				window.alert("값을 입력해주세요!");
   				document.updateDelete.name.focus();
   			} else if(isSpecial(document.updateDelete.name.value)) {
   				window.alert("이름에 특수문자가 포함되었습니다.");
   				document.updateDelete.name.focus();
   			// 학번 체크
   			} else if(document.updateDelete.iD.value.length == 0
   		   			|| document.updateDelete.iD.value == null
   		   			|| document.updateDelete.iD.value == "") {
   				window.alert("값을 입력해주세요!");
   				document.updateDelete.iD.focus();
   			} else if(!isNumeric(document.updateDelete.iD.value)) {
   				window.alert("학번은 숫자로만 구성되어 있습니다.");
   				document.updateDelete.iD.focus();
   			// 국어 점수 체크
   			} else if(document.updateDelete.kor.value.length == 0
   		   			|| document.updateDelete.kor.value == null
   		   			|| document.updateDelete.kor.value == "") {
   				window.alert("점수는 숫자만 입력 가능합니다. 값을 입력해주세요!");
   				document.updateDelete.kor.focus();
   			} else if(!isNumeric(document.updateDelete.kor.value)) {
   				window.alert("점수는 숫자만 입력 가능합니다.");
   				document.updateDelete.kor.focus();
   			// 영어 점수 체크
   			}  else if(document.updateDelete.eng.value.length == 0
   		   			|| document.updateDelete.eng.value == null
   		   			|| document.updateDelete.eng.value == "") {
   				window.alert("점수는 숫자만 입력 가능합니다. 값을 입력해주세요!");
   				document.updateDelete.eng.focus();
   			} else if(!isNumeric(document.updateDelete.eng.value)) {
   				window.alert("점수는 숫자만 입력 가능합니다.");
   				document.updateDelete.eng.focus();
   			// 수학 점수 체크
   			} else if(document.updateDelete.mat.value.length == 0
   		   			|| document.updateDelete.mat.value == null
   		   			|| document.updateDelete.mat.value == "") {
   				window.alert("점수는 숫자만 입력 가능합니다. 값을 입력해주세요!");
   				document.updateDelete.mat.focus();
   			} else if(!isNumeric(document.updateDelete.mat.value)) {
   				window.alert("점수는 숫자만 입력 가능합니다.");
   				document.updateDelete.mat.focus();
   			} else {
   				return true
   			}
   			return false
		}
    </script>
</head>
<body>
	<h1>성적 조회 후 정정 / 삭제</h1>
	<form name="selectForm" method="post" action="showREC.jsp" OnSubmit="return selectFormCheck()">
		<p style="display: inline">
			<span>조회할 학번</span>
			<span>
				<input type="text" name="studentId" /> 			
			</span>
			<span><input type="submit" value="조회" /></span>
		</p><p>
	</form>
	<form name="updateDelete" method="post" OnSubmit="return updateDeleteCheck()">
		<table border="1" width="285">
			<%  
				if(studentService.isContent(studentId)) {
					Student student = studentService.selectOne(studentId);
			%>
			<tr>
				<td width="100" align="center">이름</td>
				<td width="185" align="center"><input type="text" name="name" value="<%=student.getName()%>" /></td>
			</tr>
			<tr>
				<td width="100" align="center">학번</td>
				<td width="185" align="center"><input type="number" name="iD" value="<%=student.getStudentId()%>" /></td>
			</tr>
			<tr>
				<td width="100" align="center">국어</td>
				<td width="185" align="center"><input type="number" name="kor" min="0" max="100" value="<%=student.getKor()%>" /></td>
			</tr>
			<tr>
				<td width="100" align="center">영어</td>
				<td width="185" align="center"><input type="number" name="eng" min="0" max="100" value="<%=student.getEng()%>" /></td>
			</tr>
			<tr>
				<td width="100" align="center">수학</td>
				<td width="185" align="center"><input type="number" name="mat" min="0" max="100" value="<%=student.getMat()%>" /></td>
			</tr>
			<%} else { %>
			<tr>
				<td width="100" align="center">이름</td>
				<td width="185" align="center"><input type="text" value="해당학번없음" /></td>
			</tr>
			<tr>
				<td width="100" align="center">학번</td>
				<td width="185" align="center"><input type="number" /></td>
			</tr>
			<tr>
				<td width="100" align="center">국어</td>
				<td width="185" align="center"><input type="number" /></td>
			</tr>
			<tr>
				<td width="100" align="center">영어</td>
				<td width="185" align="center"><input type="number" /></td>
			</tr>
			<tr>
				<td width="100" align="center">수학</td>
				<td width="185" align="center"><input type="number" /></td>
			</tr>
			<%} %>
		</table>
		<table width="285" id="noneBorder">
			<tr id="noneBorder">
				<td width="150" id="noneBorder"></td>
				<td id="noneBorder">
					<input type="submit" value="수정" OnClick="javascript: updateDelete.action='updateDB.jsp'">
				</td>
				<td align="right" id="noneBorder">
					<input type="submit" value="삭제" OnClick="javascript: updateDelete.action='deleteDB.jsp'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html> 