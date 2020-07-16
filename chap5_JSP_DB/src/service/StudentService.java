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
	// U
	public Student insertDB(Student student) {
		List<Integer> studentIdList = studentDao.selectStudentId();
		List<Integer> idCheckList = new ArrayList<>();
		int emptyId = 0;
		idCheckList.add(studentIdList.get(0));
		for(int i = 1; i < studentIdList.size(); i++) {
			idCheckList.add(idCheckList.get(0) + i);
		}
		for(int i = 0; i < studentIdList.size(); i++) {
			if(studentIdList.get(i).intValue() != idCheckList.get(i).intValue()) {
				emptyId = idCheckList.get(i);
				break;
			} else {
				emptyId = studentIdList.get(studentIdList.size() - 1) + 1;
			}
		}
		student.setStudentId(emptyId);
		studentDao.insert(student);
		return selectOne(emptyId);
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
