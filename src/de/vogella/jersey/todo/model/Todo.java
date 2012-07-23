package de.vogella.jersey.todo.model;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Todo {
	
	private String id;
	private String summary;
	private String description;
	private boolean isDone;
	private boolean isDeleted;

	public Todo(){
		
	}
	
	public Todo(String id, String summary, boolean isDone) {
		super();
		this.id = id;
		this.summary = summary;
		this.isDone = isDone;
		this.isDeleted = false;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}

	public boolean getIsDone() {
		return isDone;
	}

	public void setIsDone(boolean isDone) {
		this.isDone = isDone;
	}

	public boolean isDeleted() {
		return isDeleted;
	}

	public void setDeleted(boolean isDeleted) {
		this.isDeleted = isDeleted;
	}
	

}
