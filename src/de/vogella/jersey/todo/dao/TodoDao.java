package de.vogella.jersey.todo.dao;

import java.util.HashMap;
import java.util.Map;

import de.vogella.jersey.todo.model.Todo;

public enum TodoDao {
	instance;

	private Map<String, Todo> contentProvider = new HashMap<String, Todo>();

	private TodoDao() {

		Todo todo = new Todo("1", "Learn REST", true);
		todo.setDescription("Read http://www.vogella.com/articles/REST/article.html");
		contentProvider.put(todo.getId(), todo);
		todo = new Todo("2", "Do something", false);
		todo.setDescription("Read complete http://www.vogella.com");
		contentProvider.put(todo.getId(), todo);

	}

	public Map<String, Todo> getTodos() {
		return contentProvider;
	}
	
	public void updateTodo (Todo todo){
		Todo updateTodo = contentProvider.get(todo.getId());
		updateTodo.setDescription(todo.getDescription());
		updateTodo.setSummary(todo.getSummary());
		updateTodo.setIsDone(todo.getIsDone());
		contentProvider.put(updateTodo.getId(), updateTodo);
	}

}
