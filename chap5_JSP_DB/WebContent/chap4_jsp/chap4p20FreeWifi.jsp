<%@ page contentType="text/html; charset=UTF-8"
    import="java.io.*, java.util.*" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
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
        <%! int lineCnt = 0;
            List<String> wifiAddress = new ArrayList<>();
            List<String> wifiLongitude = new ArrayList<>();
            List<String> wifiLatitude = new ArrayList<>();
            List<Double> distanceList = new ArrayList<>();
        %>
        <%
        	String relativePath = "E:\\OneDrive\\Documents\\Developer\\HighTech\\05 Enterprise Computing\\"
        						+ "기업업무프로그래밍1\\Assignment\\chap4 JSP\\전국무료와이파이표준데이터.csv";
            // String relativePath = application.getRealPath(".//chap4_jsp//전국무료와이파이표준데이터.csv");
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
    </head>
    <body>
        <table style="border-width: 1px">
            <caption>무료 와이파이 정보</caption>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>지번주소</th>
                    <th>위도</th>
                    <th>경도</th>
                </tr>
            </thead>
            <% 
            for(int i = 0; i < lineCnt; i++) {
                out.println(String.format("<tr style='text-align: center'>"));
                out.println(String.format("<td>%d</td>",i+1));
                out.println(String.format("<td>%s</td>",wifiAddress.get(i)));
                out.println(String.format("<td>%s</td>",wifiLatitude.get(i)));
                out.println(String.format("<td>%s</td>",wifiLongitude.get(i)));
                out.println(String.format("</tr>"));
            }
            %>
        </table>
    </body>
</html>