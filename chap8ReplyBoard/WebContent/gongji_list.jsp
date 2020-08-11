<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*, service.*, domain.*, java.time.LocalDate, dao.Paging"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<SCRIPT LANGUAGE="JavaScript"></SCRIPT>
	<!--bootstrap을 사용하기 위한 link-->
	<link rel="stylesheet" 
		  href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
		  integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" 
		  crossorigin="anonymous">
	<style>
		.borderingTD {
			border:1px solid black;
		}
	</style>
	<title>JSP 실습 : 댓글 게시판</title>
	<%
		ReBoardService reBoardService = new ReBoardService();
		// DB 내 모든 post record 조회
		List<RePost> postList = reBoardService.selectAll();
		StringBuilder titleBuilder = new StringBuilder();
		int rowPerPage = 10;	// 한 화면에 출력할 게시글 수
		int pagingNumPerBlock = 5;	// paging line 한 줄에 출력되는 페이지 번호의 수
		/* String getParameter("variable") method
         * request 객체의 parameter 변수 variable에 저장된 변수를 얻어내는 method return 값 = String 
         * 현재 페이지 = 브라우저의 url 중 pg로 입력 받음 (get 방식)
         * pg로 입력 받는 값이 존재하는 경우, (!=null) 
         * pg로 입력받는 값을 Integer로 type casting 하여 currentPage에 저장
         * pg로 입력 받는 값이 없는 경우, (== null)
         * currentPage = 1 저장 (처음 접속 시 = 첫 페이지)
         * fromPT, cntPT도 currentPage와 동일하게 get 방식 사용 */
		int currentPage = request.getParameter("pg") == null ? 1 : Integer.parseInt(request.getParameter("pg"));
		int fromPT = request.getParameter("from") == null ? 1 : Integer.parseInt(request.getParameter("from"));
		int cntPT = request.getParameter("cnt") == null ? rowPerPage : Integer.parseInt(request.getParameter("cnt"));
		// paging 계산해줄 Paging instance 생성
		Paging paging = new Paging(rowPerPage, pagingNumPerBlock, currentPage, fromPT, cntPT);		
	%>
</head>
<body>
	<p><h1>&nbsp&nbspJSP 실습 : 댓글 게시판</h1>
	<p>
	<table width="600px" border="1px" cellspacing="1" style="margin-left: 20px;">
		<tr class="borderingTD">
			<td class="borderingTD" width="50"><p align="center">번호</p></td>
			<td class="borderingTD" width="500"><p align="center">제목</p></td>
			<td class="borderingTD" width="100"><p align="center">등록일</p></td>
		</tr>
		<%
			if(postList.size() > 0 && postList != null) {
				for(int i = fromPT; i < (fromPT + cntPT); i++) {	
					RePost post = postList.get(i);
				// DB 내 모든 post에 대하여 반복 수행
				// for(RePost post : postList) {
					if(post.getRelevel() > 0) { // 댓글 레벨이 1 이상이면
						// 댓글 레벨만큼 하이픈 추가
						for(int relevel = 0; relevel < post.getRelevel(); relevel++) {
							titleBuilder.append("-");
						}
						// 꺽쇠와 댓글 [Re] 표시를 붙인다.
						titleBuilder.append(">[Re] ");
					}
					titleBuilder.append(post.getTitle());
					// 작성 시간과 게시글 리스트 출력시간이 같은 날짜인 경우
					if(post.getDate().equals(Date.valueOf(LocalDate.now()))) {
						titleBuilder.append(" [New]");	// 새 글 표시인 [New]를 제목 뒤에 붙인다.
					}
					String title = titleBuilder.toString();
					titleBuilder.setLength(0);
		%>
					<tr>
						<td class="borderingTD" width="50">
							<p align="center"><%=post.getId() %></p>
						</td>
						<td class="borderingTD" width="500">
							<p align="center">
								<a href="gongji_view.jsp?key=<%=post.getId()%>"><%=title %></a>
							</p>
						</td>
						<td class="borderingTD" width="100">
							<p align="center"><%=post.getDate().toLocalDate() %></p>
						</td>
					</tr>
		<%		}
			}
		%>
	</table>
	<table width="650">
		<tr>
			<td width="500"></td>
			<td><input type="button" value="신규" OnClick="window.location='gongji_insert.jsp'"></td>
	</table>
	<div class="container">
		<div class="row">
			<div class="col">
				<ul class="pagination">
					<li class="page-item">
					<%if(paging.getPrevPage() > 0) {%>
				    	<!--맨 처음 페이지로 이동 ["<<""]-->
						<a class="page-link" href="gongji_list.jsp?pg=1&from=0&cnt=<%=rowPerPage%>">&lt&lt</a>
					</li>
						<!--이전 페이지블럭으로 이동 ["<"]-->
					<li class="page-item">
						<a class="page-link" href="gongji_list.jsp?pg=<%=paging.getPrevPage()%>
							&from=<%=paging.getPrevPage()*rowPerPage-rowPerPage%>
							&cnt=<%=rowPerPage%>">
							&lt
						</a>
					</li>
					<%}
						for(int i = 1 + paging.getPrevPage();
							    i < paging.getNextPage() && i <= paging.getTotalPage() ; i++) { 
							
							if(i == paging.getTotalPage()) {%>
							
					<li class="page-item">
						<a class="page-link" href="gongji_list.jsp?
							pg=<%=i%>
							&from=<%=i*rowPerPage-rowPerPage%>
							<%if(paging.getTotalRow() % rowPerPage == 0) {%>
								&cnt=<%=rowPerPage%>">
							<%} else { %>
								&cnt=<%=paging.getTotalRow()-(int)(paging.getTotalRow()/rowPerPage)*rowPerPage%>">
							<% }%>
							<%=i%>
						</a>
					</li>
						<%} else {%>
					<li class="page-item">
						<a class="page-link" href="gongji_list.jsp?
							pg=<%=i%>
							&from=<%=i*rowPerPage-rowPerPage%>
							&cnt=<%=rowPerPage%>">
							<%=i%>
						</a>
					</li>
					<%
						  }
						}
						if(paging.getTotalPage() >= paging.getNextPage()) { %>
		        	<!--다음 페이지블럭으로 이동-->
					<li class="page-item">
						<a class="page-link" href="gongji_list.jsp?
							pg=<%=paging.getNextPage()%>
							&from=<%=paging.getNextPage()*rowPerPage-rowPerPage%>
							<%if(currentPage + 1 == paging.getTotalPage()) {%>
								&cnt=<%=paging.getTotalRow()-(int)(paging.getTotalRow()/rowPerPage)*rowPerPage%>">
							<%} else { %>
								&cnt=<%=rowPerPage%>">
							<%} %>
							&gt
						</a>
					</li>
			    	<!--맨 마지막 페이지블럭으로 이동-->
					<li class="page-item">
						<a class="page-link" href="gongji_list.jsp?
							pg=<%=paging.getTotalPage()%>
							&from=<%=(int)(paging.getTotalRow()/rowPerPage)*rowPerPage%>
							&cnt=<%=paging.getTotalRow()-(int)(paging.getTotalRow()/rowPerPage)*rowPerPage%>">
							&gt&gt
						</a>
					</li>
					<%}%>
				</ul>
			</div>		
		</div>
	</div>
</body>
</html>