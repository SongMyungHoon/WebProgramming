package unitTest;

import dao.*;
public class DaoTest {

	public static void main(String[] args) {
		BoardDao dao = BoardDao.getInstance();
		dao.dropTable();
		dao.createTable();
		dao.insertTestData();
	}
}
