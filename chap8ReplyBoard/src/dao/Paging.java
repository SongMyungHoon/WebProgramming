package dao;

public class Paging {
	// variable declaration & initializing
	private ReBoardDao reBoardDao = ReBoardDao.getInstance();
	private int rowPerPage = 10;                            // 한 화면에 출력할 데이터 수
	private int pagingNumPerBlock = 5; // paging line 한 줄에 출력되는 페이지 번호의 수
	private int totalRow = reBoardDao.selectAll().size();	// row count variable
	private int currentPage = 0;
	private int fromPT = 0;
	private int cntPT = 0;
	private int totalPage = ((totalRow - 1)/rowPerPage) + 1; // 출력해야 할 총 페이지 수
    // 이전 페이지 계산
	private int prevPage = (int)Math.floor((currentPage - 1) / pagingNumPerBlock) * pagingNumPerBlock;
    // 다음 페이지 계산
	private int nextPage = prevPage + pagingNumPerBlock + 1;
    
    public Paging(int rowPerPage, int pagingNumPerBlock, int currentPage, int fromPT, int cntPT) {
    	this.rowPerPage = rowPerPage;
    	this.pagingNumPerBlock = pagingNumPerBlock;
    	this.currentPage = currentPage;
    	this.fromPT = fromPT;
    	this.cntPT = cntPT;
    }

	public int getRowPerPage() {
		return rowPerPage;
	}

	public void setRowPerPage(int rowPerPage) {
		this.rowPerPage = rowPerPage;
	}

	public int getPagingNumPerBlock() {
		return pagingNumPerBlock;
	}

	public void setPagingNumPerBlock(int pagingNumPerBlock) {
		this.pagingNumPerBlock = pagingNumPerBlock;
	}

	public int getTotalRow() {
		return totalRow;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public int getFromPT() {
		return fromPT;
	}

	public int getCntPT() {
		return cntPT;
	}

	public int getPrevPage() {
		return prevPage;
	}

	public int getNextPage() {
		return nextPage;
	}
}


/* 현재 페이지 = 브라우저의 url 중 pg로 입력 받음 (get 방식)
 * pg로 입력 받는 값이 존재하는 경우, (!=null) 
 * pg로 입력받는 값을 Integer로 type casting 하여 currentPage에 저장
 * pg로 입력 받는 값이 없는 경우, (== null)
 * currentPage = 1 저장 (처음 접속 시 = 첫 페이지)
 * fromPT, cntPT도 currentPage와 동일하게 get 방식 사용 */

// int currentPage = request.getParameter("pg") == null ? 1 : Integer.parseInt(request.getParameter("pg"));
// int fromPT = request.getParameter("from") == null ? 0 : Integer.parseInt(request.getParameter("from"));
// int cntPT = request.getParameter("cnt") == null ? rowPerPage : Integer.parseInt(request.getParameter("cnt"));

//for(int i = fromPT; i < (fromPT + cntPT); i++) {
//out.println(String.format("<tr style='text-align: center'>"));
//out.println(String.format("<td>%d</td>", i + 1));
//out.println(String.format("<td>%s</td>", wifiAddress.get(i)));
//out.println(String.format("<td>%s</td>", wifiLatitude.get(i)));
//out.println(String.format("<td>%s</td>", wifiLongitude.get(i)));
//out.println(String.format("<td>%.8s</td>", distanceList.get(i)));
//out.println(String.format("</tr>"));
//}
