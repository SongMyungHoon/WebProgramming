package domain;

import java.sql.Date;

public class RePost {
	private int id;
	private String title;
	private Date date;
	private String content;
	private int rootId = 0;
	private int relevel = 0;
	private int recnt = 0;
	private int viewcnt = 0;
	
	public RePost() {}
	public RePost(int id, String title, Date date, String content) {
		this.id = id;
		this.title = title;
		this.date = date;
		this.content = content;
	}
	public RePost(int id, String title, Date date, String content, 
				int rootId, int relevel, int recnt, int viewcnt) {
		this.id = id;
		this.title = title;
		this.date = date;
		this.content = content;
		this.rootId = rootId;
		this.relevel = relevel;
		this.recnt = recnt;
		this.viewcnt = viewcnt;
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
	public int getRootId() {
		return rootId;
	}
	public void setRootId(int rootid) {
		this.rootId = rootid;
	}
	public int getRelevel() {
		return relevel;
	}
	public void setRelevel(int relevel) {
		this.relevel = relevel;
	}
	public int getRecnt() {
		return recnt;
	}
	public void setRecnt(int recnt) {
		this.recnt = recnt;
	}
	public int getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
}
