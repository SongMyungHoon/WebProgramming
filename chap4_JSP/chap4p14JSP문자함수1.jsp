<%--
    Page directive tag
    contentType: 현재 JSP 페이지가 생성할 문서의 콘텐츠 유형(MIME-type) 설정
                 default: text/html
                 charset=UTF-8 로 JSP 페이지의 전체 문자열 UTF-8로 지정
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
    <head>
        <%! /* Declaration Script Tag 
             * Declare Class variables */
            String str="abcdfeffasdsd";
            int str_len = str.length();
            String str_sub = str.substring(5);
            int str_loc = str.indexOf("cd");
            String strL = str.toLowerCase();
            String strU = str.toUpperCase();
        %>
    </head>
    <body>
        <%--Expression Script Tag--%>
        Str: <%=str%> <br>
        str_leng: <%=str_len%> <br>
        str_sub: <%=str_sub%> <br>
        str_loc: <%=str_loc%> <br>
        strL: <%=strL%> <br>
        strU: <%=strU%> <br>
        Good...
    </body>
</html>