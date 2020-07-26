package service;

import dao.*;
import domain.*;
import java.util.*;

public class ReBoardService {
	private static ReBoardDao reBoardDao = ReBoardDao.getInstance();
	
	// R: 특정 게시글을 Database에서 조회
	public RePost selectOne(int postId) {
		return reBoardDao.selectOne(postId);
	}
	public RePost lastInsertedPost() {
		int lastId = reBoardDao.lastInsertedPostId();
		return reBoardDao.selectOne(lastId);
	}
	// R: Database 내 모든 데이터 조회
	public List<RePost> selectAll() {
		return reBoardDao.selectAll();
	}
	
	public int selectReCnt(int rootId) {
		return reBoardDao.selectReCnt(rootId);
	}
	
	// R: Database 내 모든 데이터 조회
	public List<RePost> selectAllRootPost() {
		return reBoardDao.selectAllRootPost();
	}
	
	// D: 해당 게시글을 Database에서 삭제
	public String delete(int postId) {
		if(reBoardDao.delete(postId)) {
			return "게시글이 삭제되었습니다.";
		} else {
			return "게시글 삭제 실패";
		}
	}
	
	// U: 해당 게시글을 Database에서 저장
	public String insert(RePost post) {
		if(reBoardDao.insert(post)) {
			return "게시글이 등록되었습니다.";
		} else {
			return "게시글 등록 실패";
		}
	}
	
	// U: 해당 댓글을 Database에서 저장
	public String reInsert(RePost post) {
		if(reBoardDao.reInsert(post)) {
			return "댓글이 등록되었습니다.";
		} else {
			return "댓글 등록 실패";
		}
	}
	
	// U: 해당 게시글을 Database에서 수정
	public String update(RePost post) {
		if(reBoardDao.update(post)) {
			return "게시글이 수정되었습니다.";
		} else {
			return "게시글 수정 실패";
		}
	}
	
	// U: 해당 게시글의 조회수 증가를 갱신
	public void viewCntUpdate(RePost post) {
		reBoardDao.viewCntUpdate(post);
	}
}
