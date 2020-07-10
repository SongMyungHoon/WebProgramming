<%@ page contentType="text/html; charset=UTF-8" %>

<%--request.setCharacterEncoding("Argument");
    - POST 방식에서의 한글 처리 방법
    - request는 JSP built-in 객체로 HTTP 요청한 사용자의 정보를 담고 있는 객체
    - setCharacterEncoding method는 Client가 전달한 요청 정보 body에 있는 문자열들을 
      method argument 값으로 지정한 문자코드로 인코딩 수행
    - 주의사항! getParamter 앞 부분에 위치해야함 --%>
<% request.setCharacterEncoding("UTF-8"); %>

<%  /* String getParameter("variable") method
     * parameter 변수 variable에 저장된 변수를 얻어내는 method
     * return 값 = String */
    String name = request.getParameter("username");
    String password = request.getParameter("userpasswd");
%>
<html>

<head> 
    <title>로그인</title>
</head>

<body>
    <%--Expression Script Tag: name 값 출력--%>
    이름 : <%= name %> <br>
    <%--Expression Script Tag: password 값 출력--%>
    비밀번호 : <%= password %> <br>
</body>

</html>