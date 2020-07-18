package service;

import dao.*;
import domain.*;
import java.util.*;

public class BoardService {
	private static BoardDao boardDao = BoardDao.getInstance();
	
	// R
	public Post selectOne(int postId) {
		return boardDao.selectOne(postId);
	}
	// R
	public List<Post> selectAll() {
		return boardDao.selectAll();
	}
}
