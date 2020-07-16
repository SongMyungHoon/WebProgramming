<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.io.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>FreeWifi Web page</title>
        <style>
            table {
                width: 100%;
                border: 1px solid #444444;
            }
            th, td {
                border: 1px solid #444444;
            }
        </style>
        <%	// variable declaration & initializing
            List<String> wifiAddress = new ArrayList<>();
            List<String> wifiLongitude = new ArrayList<>();
            List<String> wifiLatitude = new ArrayList<>();
            List<Double> distanceList = new ArrayList<>();
            int rowPerPage = 10;  // 한 화면에 출력할 데이터 수
            int pagingNumPerBlock = 10; // paging line 한 줄에 출력되는 페이지 번호의 수
            int totalRow = 0;   // 전체 데이터의 수 (WIFI 개수)
            int totalPage = 0;  // 출력해야 할 총 페이지 수
            int lineCnt = 0;    // row count variable
            
            /* 현재 페이지 = 브라우저의 url 중 pg로 입력 받음 (get 방식)
             * pg로 입력 받는 값이 존재하는 경우, (!=null) 
             * pg로 입력받는 값을 Integer로 type casting 하여 currentPage에 저장
             * pg로 입력 받는 값이 없는 경우, (== null)
             * currentPage = 1 저장 (처음 접속 시 = 첫 페이지)
             * fromPT, cntPT도 currentPage와 동일하게 get 방식 사용 */
            int currentPage = request.getParameter("pg") == null ? 1 : Integer.parseInt(request.getParameter("pg"));
            int fromPT = request.getParameter("from") == null ? 0 : Integer.parseInt(request.getParameter("from"));
            int cntPT = request.getParameter("cnt") == null ? rowPerPage : Integer.parseInt(request.getParameter("cnt"));
            
        %>
        <%	/* row data load from file read */
        	//String relativePath = "E:\\OneDrive\\Documents\\Developer\\HighTech\\"
        	//						+ "05 Enterprise Computing\\BIZ프로그래밍기초\\실습데이터\\전국무료와이파이표준데이터.csv";
            // String relativePath = application.getRealPath(".//chap4_jsp//전국무료와이파이표준데이터.csv");
            String relativePath = "C:\\Users\\MHSong\\OneDrive\\Documents\\Developer\\HighTech\\05 Enterprise Computing\\"
            		+ "기업업무프로그래밍1\\Assignment\\chap4 JSP\\전국무료와이파이표준데이터.csv";
            try {
                File f = new File(relativePath);
                BufferedReader bufferedReader = new BufferedReader(new FileReader(f));
                String readTxt;
                double latitude = 37.3860521;
                double longitude = 127.1214038;
                
                PrintWriter printWriter = response.getWriter();
                StringBuilder stringBuilder = new StringBuilder();
                double distance = 0;
                
                if((readTxt = bufferedReader.readLine()) == null) {
                    printWriter.printf("빈 파일입니다\n");
                }
                String[] field_name = readTxt.split(",");
                while((readTxt = bufferedReader.readLine()) != null) {
                    // 읽은 String data 안에 쌍따옴표가 존재한다면
                    if(readTxt.contains("\"")) {
                        
                        // 쌍따옴표를 기준으로 split
                        String[] strManField = readTxt.split("\"");
                         
                        // split한 결과 array의 length가 3 이상이라면
                        if(strManField.length >= 3) {
                            
                            /* 쌍따옴표 쌍의 수 = i 라 하면, String array.length = 1 + 2i
                             * maximum i = (String array.length - 1 / 2) = (int) String array.length/2
                             * 콤마 제거해야하는 array의 index = 1 + 2*i
                             */
                            for(int i = 0; i < strManField.length/2; i++) {
                                
                                /* index = 홀수 인 String array element의 콤마를 온점(dot)으로 변경
                                 * 수정해야할 data가 많다면, searching algorithm을 적용해 
                                 * 수정이 필요한(쌍따옴표가 존재하는) column만 replace하는 것을 고려해볼만 하다.
                                 */
                                strManField[1 + i*2] = strManField[1 + i*2].replace(",", ".");
                            }	// for end
                        }	// if end
                        // readTxt 변수 초기화
                        readTxt = "";
                        
                        for(int i = 0; i < strManField.length; i++) {
                            // manipulation 후 String 재조립
                            stringBuilder.append(strManField[i]);
                        }	// for end
                        readTxt = stringBuilder.toString();
                        stringBuilder.setLength(0);
                    }	// if end

                    String[] field = readTxt.split(",");
                    // 피타고라스 정리로 거리 계산하기
                    distance = Math.sqrt(Math.pow(Double.parseDouble(field[12]) - latitude, 2) 
                               + Math.pow(Double.parseDouble(field[13]) - longitude, 2));
                    wifiAddress.add(field[9]);
                    wifiLongitude.add(field[13]);
                    wifiLatitude.add(field[12]);
                    distanceList.add(distance);
                    lineCnt++;
                    
                }   // while loop end
                bufferedReader.close();
            } catch(IOException e) {
                out.println(e);
            }
        %>
        <%	/* Paging data calculate */
	        totalRow = lineCnt; // 전체 데이터 수 계산
	        totalPage = ((totalRow - 1)/rowPerPage) + 1; // 전체 페이지 수 계산
            // 이전페이지 계산
	        int prevPagingBlock = (int)Math.floor((currentPage - 1) / pagingNumPerBlock) * pagingNumPerBlock;
	        // 다음 페이지 계산
	        int nextPagingBlock = prevPagingBlock + pagingNumPerBlock + 1;
        %>
    </head>
    
    <body>
    	<%--Main record print part --%>
        <table style="border-width: 1px">
            <caption><H2>무료 와이파이 정보</H2></caption>
            <thead>
                <tr>
                    <!--Table Head-->
                    <th>번호</th>
                    <th>지번주소</th>
                    <th>위도</th>
                    <th>경도</th>
                    <th>현재 지점과 거리</th>
                </tr>
            </thead>
            <%  // record 출력, 출력 범위 [fromPT ~ (fromPT + cntPT)]
	            for(int i = fromPT; i < (fromPT + cntPT); i++) {
	                out.println(String.format("<tr style='text-align: center'>"));
	                out.println(String.format("<td>%d</td>",i+1));
	                out.println(String.format("<td>%s</td>",wifiAddress.get(i)));
	                out.println(String.format("<td>%s</td>",wifiLatitude.get(i)));
	                out.println(String.format("<td>%s</td>",wifiLongitude.get(i)));
	                out.println(String.format("<td>%.8s</td>",distanceList.get(i)));
	                out.println(String.format("</tr>"));
	            }
            %>
        </table>
        
        <!--Paging part-->
        <table border="0" align="center" width="0%" cellpadding="0" cellspacing="0">
			<tr>
				<td>
                    <!--맨 처음 페이지로 이동 ["<<""]-->
					<a href="chap4p22FreeWifi3.jsp?pg=1&from=0&cnt=<%=rowPerPage%>">&lt&lt</a>
					<!--이전 페이지블럭으로 이동 ["<"]-->
                    <% if(prevPagingBlock > 0) { %>
						<a href="chap4p22FreeWifi3.jsp?pg=<%=prevPagingBlock%>
							&from=<%=prevPagingBlock*rowPerPage-rowPerPage%>
							&cnt=<%=rowPerPage%>">
							&lt
						</a>
					<%}%>
					<%for(int i = 1 + prevPagingBlock; i < nextPagingBlock && i <= totalPage ; i++) { 
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
						</a>
					<%}%>
				</td>
			</tr>
		</table>
    </body>
</html>