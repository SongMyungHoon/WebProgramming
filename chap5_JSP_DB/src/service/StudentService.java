package service;

import java.util.*;
import dao.StudentDao;
import domain.Student;

public class StudentService {
	private static StudentDao studentDao = StudentDao.getInstance();

	// C
	public String createTable() {
		return studentDao.createTable();
	}
	// R
	public Student selectOne(int studentId) {
		return studentDao.selectOne(studentId);
	}
	// R
	public List<Student> selectAll() {
		return studentDao.selectAll();
	}
	// U
	public String insert(Student student) {
		return studentDao.insert(student);
	}
	// U
	public boolean update(Student student) {
		return studentDao.update(student);
	}
	public boolean isContent(int inputStudentId) {
		List<Integer> studentIdList = studentDao.selectStudentId();
		for(int studentId : studentIdList) {
			if(studentId == inputStudentId) {
				return true;
			}
		}
		return false;
	}
	/* Database에 연속적이지 않는 ID가 존재하는 경우
	 * 해당 ID로 학번 부여, 아닌 경우 마지막 학번에 1을 더해 학번 부여*/ 
	public Student insertDB(Student student) {
		List<Integer> studentIdList = studentDao.selectStudentId();
		List<Integer> idCheckList = new ArrayList<>();
		int emptyId = 0;
		idCheckList.add(studentIdList.get(0)); // 첫 번째 학번을 기준으로 1씩 더한다.
		for(int i = 1; i < studentIdList.size(); i++) {
			// 첫번째 학번부터 1씩 더해 첫번째학번~studentIdList size 만큼의 element 더함
			idCheckList.add(idCheckList.get(0) + i);
		}
		for(int i = 0; i < studentIdList.size(); i++) {
			// database에 존재하는 실제 학번과 비교하여 다른 값이 있는 경우 break
			if(studentIdList.get(i).intValue() != idCheckList.get(i).intValue()) {
				emptyId = idCheckList.get(i); // 빈 학번을 새 학생의 학번으로 지정
				break;
			} else {
				// 중간에 빈 학번이 없는 경우 마지막 학번+1 을 학번으로 지정
				emptyId = studentIdList.get(studentIdList.size() - 1) + 1;
			}
		}
		student.setStudentId(emptyId);
		studentDao.insert(student); // insert query 수행
		return selectOne(emptyId);	// Database에서 insert query 수행 결과를 조회해 return
	}
		
	// D
	public String dropTable() {
		return studentDao.dropTable();
	}
	// D
	public boolean delete(Student student) {
		return studentDao.delete(student);
	}
}
