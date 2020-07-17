package service;

import domain.Hubo;
import domain.Tupyo;
import java.util.*;
import dao.VoteDao;

public class VoteService {
	VoteDao voteDao = VoteDao.getInstance();
	
	public List<Hubo> selectAllHubo() {
		return voteDao.selectAllHubo();
	}
	
	public int voteCountOne(int id) {
		return voteDao.selectOneCountTupyo(id);
	}
	
	public double voteRateCal(int id) {
		int voteCount = voteDao.selectOneCountTupyo(id);
		int totalVoteCount = voteDao.selectAllCountTupyo();
		double voteRate = (double) voteCount / totalVoteCount * 10000;
		voteRate = Math.round(voteRate) / 100.0;
		return voteRate;
	}
	
	public String insertHubo(Hubo hubo) {
		if(voteDao.insertHubo(hubo)) {
			return "후보등록 결과 : 후보가 추가되었습니다.";
		} else {
			return "후보등록 결과 : 후보등록 실패";
		}
	}
	
	public String deleteHubo(int id) {
		if(voteDao.delete(id)) {
			return "후보등록 결과 : 후보가 삭제되었습니다.";
		} else {
			return "후보등록 결과 : 후보삭제 실패";
		}
	}
	
	public String insertTupyo(Tupyo tupyo) {
		if(voteDao.insertTupyo(tupyo)) {
			return "투표 결과 : 투표하였습니다.";
		} else {
			return "투표 결과 : 투표 실패";
		}
	}
	
	public List<Double> tendencyRateList(int id) {
		int voteCount = voteDao.selectOneCountTupyo(id);
		List<Integer> tendencyCountList = voteDao.selectTupyoCountEachAge(id).get(1);
		List<Double> tendencyRateList = new ArrayList<>();
		double tendencyRate;
		for(int tendencyCount : tendencyCountList) {
			tendencyRate = (double) tendencyCount / voteCount * 10000;
			tendencyRate = Math.round(tendencyRate) / 100.0;
			tendencyRateList.add(tendencyRate);
		}
		return tendencyRateList;
	}
	
	public List<List<Integer>> ageTendency(int id) {
		return voteDao.selectTupyoCountEachAge(id);
	}
}
