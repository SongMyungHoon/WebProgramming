package test;
import static org.junit.Assert.assertTrue;
import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.Test;

import dao.StudentDao;
import domain.Student;
import service.StudentService;

public class DaoTest {
	@Test
	public void testInsert() {
		StudentService studentService = new StudentService();
		String name = "시발";
		int studentId = 0;
		int kor = 45;
		int eng = 11;
		int mat = 19;
		Student student = new Student(name, studentId, kor, eng, mat);
		
//		assertTrue(studentService.update(student));
//		assertEquals("김염병의 데이터 입력 완료", dao.insert(student));
		assertEquals(209911, studentService.insertDB(student).getStudentId());
	}
}
