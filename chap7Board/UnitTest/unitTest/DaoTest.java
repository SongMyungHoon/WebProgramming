package unitTest;

import dao.*;
import service.*;
public class DaoTest {

	public static void main(String[] args) {
		BoardDao dao = BoardDao.getInstance();
		BoardService service = new BoardService();
//		dao.dropTable();
//		dao.createTable();
//		dao.insertTestData();
		System.out.println("lastInsertedPostId = " + dao.lastInsertedPostId());
		System.out.println("lastInsertedPost = " + service.lastInsertedPost().getId());
	}
}
