package domain;

import java.sql.Date;

public class Post {
	private int id;
	private String title;
	private Date date;
	private String content;
	
	public Post() {}
	public Post(int id, String title, Date date, String content) {
		this.id = id;
		this.title = title;
		this.date = date;
		this.content = content;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}
