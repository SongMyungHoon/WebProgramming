<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>대출금 계산 결과</title>

    <style>
        table, th, td {
            border: 1px solid #bcbcbc;
        }  
    </style>
    <%
        int loanVal = Integer.parseInt(request.getParameter("loan"));
    	int loanRates = Integer.parseInt(request.getParameter("loanRates"));
    	int loanPeriod = Integer.parseInt(request.getParameter("loanPeriod"));
    	double loanPeriodYear = (int)((double)loanPeriod/12*100)/100;
    	int unredeemedTerm = Integer.parseInt(request.getParameter("unredeemedTerm"));
    %>
</head>

<body>
    <table>
        <tr>
            <td>대출금</td>
            <td> <%=loanVal %>원</td>
        </tr>
        <tr>
            <td>대출금리</td>
            <td>연 <%=loanRates %> %</td>
        </tr>
        <tr>
            <td>대출기간</td>
            <td><%=loanPeriod %> 개월 (<%=(double)loanPeriodYear %> 년)</td>
        </tr>
        <tr>
            <td>거치기간</td>
            <td><%=unredeemedTerm %></td>
        </tr>
        <tr>
            <td>상환방법</td>
            <td>원리금균등상환</td>
        </tr>
        <tr>
            <td>총이자</td>
            <td> 원</td>
        </tr>
    </table>
    <input type="button" value="다시 계산하기" onclick="location.href='index.html'">
    <br>
    <br>
    ☞ 월별 상환금<br>
    <table>
        <thead>
            <tr>
                <th style="text-align: center;">No</th>
                <th style="text-align: center;">상환금</th>
                <th style="text-align: center;">닙입원금</th>
                <th style="text-align: center;">이자</th>
                <th style="text-align: center;">납입원금계</th>
                <th style="text-align: center;">잔금</th>
            </tr>
        </thead>
    </table>
</body>
</html>
