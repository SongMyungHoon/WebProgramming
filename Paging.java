
public Paging() {
    // variable declaration & initializing
    int rowPerPage = 10;  // 한 화면에 출력할 데이터 수
    int pagingNumPerBlock = 10; // paging line 한 줄에 출력되는 페이지 번호의 수
    int totalRow = 0;   // 전체 데이터의 수 (WIFI 개수)
    int totalPage = 0;  // 출력해야 할 총 페이지 수
    int lineCnt = reBoardDao.selectAll().size();    // row count variable
    int currentPage = 0;
    int fromPT = 0;
    int cntPT = 0;

    /* 현재 페이지 = 브라우저의 url 중 pg로 입력 받음 (get 방식)
        * pg로 입력 받는 값이 존재하는 경우, (!=null) 
        * pg로 입력받는 값을 Integer로 type casting 하여 currentPage에 저장
        * pg로 입력 받는 값이 없는 경우, (== null)
        * currentPage = 1 저장 (처음 접속 시 = 첫 페이지)
        * fromPT, cntPT도 currentPage와 동일하게 get 방식 사용 */
    
    // int currentPage = request.getParameter("pg") == null ? 1 : Integer.parseInt(request.getParameter("pg"));
    // int fromPT = request.getParameter("from") == null ? 0 : Integer.parseInt(request.getParameter("from"));
    // int cntPT = request.getParameter("cnt") == null ? rowPerPage : Integer.parseInt(request.getParameter("cnt"));
    
    /* Paging data calculate */
    totalRow = lineCnt; // 전체 데이터 수 계산
    totalPage = ((totalRow - 1)/rowPerPage) + 1; // 전체 페이지 수 계산
    // 이전페이지 계산
    int prevPagingBlock = (int)Math.floor((currentPage - 1) / pagingNumPerBlock) * pagingNumPerBlock;
    // 다음 페이지 계산
    int nextPagingBlock = prevPagingBlock + pagingNumPerBlock + 1;

    for(int i = fromPT; i < (fromPT + cntPT); i++) {
        out.println(String.format("<tr style='text-align: center'>"));
        out.println(String.format("<td>%d</td>",i+1));
        out.println(String.format("<td>%s</td>",wifiAddress.get(i)));
        out.println(String.format("<td>%s</td>",wifiLatitude.get(i)));
        out.println(String.format("<td>%s</td>",wifiLongitude.get(i)));
        out.println(String.format("<td>%.8s</td>",distanceList.get(i)));
        out.println(String.format("</tr>"));
    }
}
/*    
    <!--맨 처음 페이지로 이동 ["<<""]-->
    <a href="chap4p22FreeWifi3.jsp?pg=1&from=0&cnt=<%=rowPerPage%>">&lt&lt</a>
    <!--이전 페이지블럭으로 이동 ["<"]-->
    <% if(prevPagingBlock > 0) { %>
        <a href="chap4p22FreeWifi3.jsp?pg=<%=prevPagingBlock%>
            &from=<%=prevPagingBlock*rowPerPage-rowPerPage%>
            &cnt=<%=rowPerPage%>">
            &lt
        
    }
    for(int i = 1 + prevPagingBlock; i < nextPagingBlock && i <= totalPage ; i++) { 
            if(i == totalPage) { %>
                    <a href="chap4p22FreeWifi3.jsp?
                        pg=<%=i%>
                        &from=<%=i*rowPerPage-rowPerPage%>
                        &cnt=<%=totalRow-(int)(totalRow/rowPerPage)*rowPerPage%>">
                        <%=i%>
                    </a>
                <%} else {%>
                    <a href="chap4p22FreeWifi3.jsp?
                        pg=<%=i%>
                        &from=<%=i*rowPerPage-rowPerPage%>
                        &cnt=<%=rowPerPage%>">
                        <%=i%>
                    </a>
                <%
                }
            }
            if(totalPage >= nextPagingBlock) { %>
                <!--다음 페이지블럭으로 이동-->
                <a href="chap4p22FreeWifi3.jsp?
                    pg=<%=nextPagingBlock%>
                    &from=<%=nextPagingBlock*rowPerPage-rowPerPage%>
                    &cnt=<%=rowPerPage%>">
                    &gt
                </a>
                <!--맨 마지막 페이지블럭으로 이동-->
                <a href="chap4p22FreeWifi3.jsp?
                    pg=<%=totalPage%>
                    &from=<%=(int)(totalRow/rowPerPage)*rowPerPage%>
                    &cnt=<%=totalRow-(int)(totalRow/rowPerPage)*rowPerPage%>">
                    &gt&gt

            <%}%>


*/