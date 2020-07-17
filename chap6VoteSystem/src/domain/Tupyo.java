package domain;

public class Tupyo {
	private int id;
	private int age;
	
	public Tupyo() {}
	
	public Tupyo(int id, int age) {
		this.id = id;
		this.age = age;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}
}
