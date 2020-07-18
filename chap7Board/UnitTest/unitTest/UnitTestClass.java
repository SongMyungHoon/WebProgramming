package unitTest;

import static org.junit.Assert.assertEquals;
import org.junit.Test;
import dao.*;
import service.*;
import domain.*;
import java.sql.Date;
import java.time.LocalDate;

public class UnitTestClass {
	@Test
	public void testMethod() {
		BoardService boardService = new BoardService();
		int id = 5;
		String title = "공지사항5";
		Date date = Date.valueOf("2020-07-18");
		String content = "공지사항내용5";
		Post post = new Post(id, title, date, content);
		
		assertEquals(post.getTitle(),boardService.selectOne(5).getTitle());
	}
}
