<%--
    Page directive tag
    import: 현재 JSP 페이지가 사용할 Java class 설정
    contentType: 현재 JSP 페이지가 생성할 문서의 콘텐츠 유형(MIME-type) 설정, default: text/html
                 charset=UTF-8 로 JSP 페이지의 전체 문자열 UTF-8로 지정
--%>
<%@ page import="java.sql.*,
    javax.mail.*, javax.mail.internet.*"
    contentType="text/html; charset=UTF-8" %>
<html>
    <body>
        <%--Scriptlet tag: declare a local variable--%>
        <% String myUrl = "http://kopo.ac.kr"; %>
        
        <%--문자열 Hello에 myUrl에 해당하는 웹 페이지 하이퍼링크 연결--%>
        <a href="<%= myUrl %>">Hello</a> World.
    </body>
</html>