<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
</head>

<body>
    <!-- form tag: post 방식으로 사용자 입력값을 서버에 전달
            action 속성: form data를 서버로 보낼 때 해당 데이터가 도착할 URL을 명시
    -->
    <form method="post" action="member.jsp">
        <!-- input tag:
             사용자로부터 입력을 받을 수 있는 input field를 정의할 때 사용
             사용자가 데이터를 입력할 수 있는 input field를 선언하기 위해
             <form> 요소 내부에서 사용된다.
             <input> 요소는 빈 태그이며, 속성만을 포함하고 있고,
             <label> 요소를 사용하면 <input> 요소의 label을 정의할 수도 있다.
             
             속성:
                name(text): <input> 요소의 이름을 명시
                type(button, password, text, submit.. etc): <input> 요소가 나타낼 타입 명시
                    - text: 텍스트를 입력하는 창 생성
                    - password: 비밀번호를 입력하는 창을 생성
                    - submit : 서버로 제출/전송하는 버튼 생성
                value(text): <input> 요소의 초기값(value) 명시
        -->
        이름 : <input type="text" name="username"><br>
        비밀번호 : <input type="password" name="userpasswd"><br>
        <input type="submit" value="전송">
    </form>
</body>

</html>