package test;

import static org.junit.Assert.assertEquals;
import org.junit.Test;

import dao.VoteDao;
import domain.Hubo;
import domain.Tupyo;
import service.VoteService;

public class serviceTest {
	@Test
	public void testMethod() {
		VoteService voteService = new VoteService();
		VoteDao dao = VoteDao.getInstance();
		int id = 1;
		int age = 3;
		
		assertEquals((double) 40, voteService.voteRateCal(id));
	}
}