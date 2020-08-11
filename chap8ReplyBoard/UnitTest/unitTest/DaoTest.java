package unitTest;

import dao.*;
public class DaoTest {

	public static void main(String[] args) {
		ReBoardDao dao = ReBoardDao.getInstance();
		dao.dropTable();
		dao.createTable();
		dao.insertTestData();
		dao.addField();
//		int rowPerPage = 20;
//		int pagingNumPerBlock = 10;
//		int currentPage = 1;
//		int fromPT = 1;
//		int cntPT = 30;
//		Paging paging = new Paging(rowPerPage, pagingNumPerBlock, currentPage, fromPT, cntPT);
		
//		System.out.println(paging.getNextPagingBlock());
	}
}
