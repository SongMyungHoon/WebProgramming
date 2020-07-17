package service;

import domain.Hubo;
import domain.Tupyo;
import java.util.*;
import dao.VoteDao;

public class VoteService {
	VoteDao voteDao = VoteDao.getInstance();
	// hubo_table의 모든 record 조회
	public List<Hubo> selectAllHubo() {
		return voteDao.selectAllHubo();
	}
	// tupyo_table의 record 중 id에 해당하는 record의 count를 조회
	public int voteCountOne(int id) {
		return voteDao.selectOneCountTupyo(id);
	}
	// 해당 id의 득표율을 계산해 return
	public double voteRateCal(int id) {
		// 해당 id의 득표 수
		int voteCount = voteDao.selectOneCountTupyo(id);
		// tupyo_table의 전체 record count 수
		int totalVoteCount = voteDao.selectAllCountTupyo();
		/*득표율 = 특정 후보 득표 수 / 전체 투표 수
		  소수점 셋째자리에서 반올림 */
		double voteRate = (double) voteCount / totalVoteCount * 10000;
		voteRate = Math.round(voteRate) / 100.0;
		return voteRate;
	}
	// 해당 후보를 Database에 등록
	public String insertHubo(Hubo hubo) {
		if(voteDao.insertHubo(hubo)) {
			return "후보등록 결과 : 후보가 추가되었습니다.";
		} else {
			return "후보등록 결과 : 후보등록 실패";
		}
	}
	// 해당 후보를 Database에서 삭제
	public String deleteHubo(int id) {
		if(voteDao.delete(id)) {
			return "후보등록 결과 : 후보가 삭제되었습니다.";
		} else {
			return "후보등록 결과 : 후보삭제 실패";
		}
	}
	// 투표 결과를 Database에 저장
	public String insertTupyo(Tupyo tupyo) {
		if(voteDao.insertTupyo(tupyo)) {
			return "투표 결과 : 투표하였습니다.";
		} else {
			return "투표 결과 : 투표 실패";
		}
	}
	// 해당 id의 후보 정보를 DB에서 조회
	public Hubo selectOneHubo(int id) {
		return voteDao.selectOne(id);
	}
	// 연령대에 따른 득표율을 계산하여 return
	public List<Double> tendencyRateList(int id) {
		// 특정 후보의 득표 수를 Database에서 조회
		int voteCount = voteDao.selectOneCountTupyo(id);
		// 특정 후보의 특정 연령대에 따른 득표 수를 조회해서 List에 저장
		List<Integer> tendencyCountList = voteDao.selectTupyoCountEachAge(id).get(1);
		List<Double> tendencyRateList = new ArrayList<>();
		double tendencyRate;
		for(int tendencyCount : tendencyCountList) {
			// 연령대별 득표율 = 연령대 별 득표 수 / 전체 득표수 * 100
			tendencyRate = (double) tendencyCount / voteCount * 10000;
			// 소수점 셋째자리에서 반올림
			tendencyRate = Math.round(tendencyRate) / 100.0;
			tendencyRateList.add(tendencyRate);
		}
		// 계산된 연령대별 득표율 List를 return
		return tendencyRateList;
	}
	// 특정 후보에 대한 연령대별 득표수를 조회	
	public List<List<Integer>> ageTendency(int id) {
		return voteDao.selectTupyoCountEachAge(id);
	}
}
