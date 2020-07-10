<%--
    Page directive tag
    contentType: 현재 JSP 페이지가 생성할 문서의 콘텐츠 유형(MIME-type) 설정, default: text/html
                 charset=UTF-8 로 JSP 페이지의 전체 문자열 UTF-8로 지정
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
    
<head>
    <%! /* Declaration Script Tag 
         * Declare call1, call2 method */
        private String call1(){
            String a = "abc";
            String b = "efg";
            return (a+b);
        }
        private Integer call2() {
            Integer a = 1;
            Integer b = 2;
            return (a+b);
        }
    %>
</head>

<body>
    <%--Expression Script Tag: call call1, call2 method--%>
    String연산 : <%=call1()%> <br>
    Integer연산 : <%=call2()%> <br>
    Good...
</body>

</html>