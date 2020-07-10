<%--
    Page directive tag
    contentType: 현재 JSP 페이지가 생성할 문서의 콘텐츠 유형(MIME-type) 설정
                 default: text/html
                 charset=UTF-8 로 JSP 페이지의 전체 문자열 UTF-8로 지정
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>

<head></head>

<body>
    <%  /* Scriptlet Script Tag: declare a local variable */
        String arr[] = new String[]{"111","222","333"};
        String str = "abc,efg,hij";
        String str_arr[] = str.split(",");
    %>
    <%--Expression Script Tag--%>
    arr[0]: <%=arr[0]%> <br>
    arr[1]: <%=arr[1]%> <br>
    arr[2]: <%=arr[2]%> <br>
    str_arr[0]: <%=str_arr[0]%> <br>
    str_arr[1]: <%=str_arr[1]%> <br>
    str_arr[2]: <%=str_arr[2]%> <br>
    Good...
</body>

</html>