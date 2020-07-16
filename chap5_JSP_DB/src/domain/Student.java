package domain;

public class Student {
	private String name;
	private int studentId;
	private int kor;
	private int eng;
	private int mat;
	// constructor
	public Student(String name, int studentId, int kor, int eng, int mat) {
		this.name = name;
		this.studentId = studentId;
		this.kor = kor;
		this.eng = eng;
		this.mat = mat;
	}
	// getter and setter
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getStudentId() {
		return studentId;
	}
	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}
	public int getKor() {
		return kor;
	}
	public void setKor(int kor) {
		this.kor = kor;
	}
	public int getEng() {
		return eng;
	}
	public void setEng(int eng) {
		this.eng = eng;
	}
	public int getMat() {
		return mat;
	}
	public void setMat(int mat) {
		this.mat = mat;
	}
}