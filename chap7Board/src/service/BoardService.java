package service;

import dao.*;
import domain.*;
import java.util.*;

public class BoardService {
	private static BoardDao boardDao = BoardDao.getInstance();
	
	// R: 특정 게시글을 Database에서 조회
	public Post selectOne(int postId) {
		return boardDao.selectOne(postId);
	}
	
	// R: Database 내 모든 데이터 조회
	public List<Post> selectAll() {
		return boardDao.selectAll();
	}
	
	public Post lastInsertedPost() {
		int lastId = boardDao.lastInsertedPostId();
		return boardDao.selectOne(lastId);
	}
	
	// D: 해당 게시글을 Database에서 삭제
	public String delete(int postId) {
		if(boardDao.delete(postId)) {
			return "게시글이 삭제되었습니다.";
		} else {
			return "게시글 삭제 실패";
		}
	}
	
	// U: 해당 게시글을 Database에서 저장
	public String insert(Post post) {
		if(boardDao.insert(post)) {
			return "게시글이 등록되었습니다.";
		} else {
			return "게시글 등록 실패";
		}
	}
	
	// U: 해당 게시글을 Database에서 수정
	public String update(Post post) {
		if(boardDao.update(post)) {
			return "게시글이 수정되었습니다.";
		} else {
			return "게시글 수정 실패";
		}
	}
}
