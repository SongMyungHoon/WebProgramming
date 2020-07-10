<%--
    Page directive tag
    contentType: 현재 JSP 페이지가 생성할 문서의 콘텐츠 유형(MIME-type) 설정
                 default: text/html
                 charset=UTF-8 로 JSP 페이지의 전체 문자열 UTF-8로 지정
    errorPage: 현재 JSP 페이지에 오류가 발생했을 때 보여줄 오류 페이지 설정
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<html>
    <head></head>
    <body>
        <%  /* Scriptlet Script Tag: _jspService() method 내부 */
            String arr[] = new String[]{"111","222","333"};
            try {
                out.println(arr[4]+"<br>"); // 웹 페이지에 출력
            } catch(Exception e) {          // 웹 페이지에 에러 출력
                out.println("error==>"+e+"<========<br>");
            }
        %>
        Good...
    </body>
</html>