<%--
    Page directive tag
    contentType: 현재 JSP 페이지가 생성할 문서의 콘텐츠 유형(MIME-type) 설정, default: text/html
                 charset=UTF-8 로 JSP 페이지의 전체 문자열 UTF-8로 지정
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
    <head>
        <%! /* Declaration Script Tag 
             * Declare AA class, Sum method and create aa instance */
            private class AA {
                private int Sum(int i, int j) {
                    return i + j;
                }
            }
            AA aa = new AA();
        %>
    </head>
    <body>
        <%--Scriptlet tag: call the aa.Sum method --%>
        <% out.println("2+3=" + aa.Sum(2,3));%> <br>
    </body>
</html>