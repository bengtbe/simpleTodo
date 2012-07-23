package de.vogella.jersey.todo.dao;

import java.util.HashMap;
import java.util.Map;

import de.vogella.jersey.todo.model.Todo;

public enum TodoDao {
	instance;

	private Map<String, Todo> contentProvider = new HashMap<String, Todo>();
	private int nextId = 1;
	
	private TodoDao() {

		Todo todo = new Todo("Learn REST", true);
		todo.setDescription("Read http://www.vogella.com/articles/REST/article.html");
		addTodo(todo);
		todo = new Todo("Do something", false);
		todo.setDescription("Read complete http://www.vogella.com");
		addTodo(todo);

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
	
	public void addTodo(Todo todo){
		
		todo.setId(String.valueOf(nextId++));
		contentProvider.put(todo.getId(), todo);
	}

	public void deleteTodo(String id) {
		contentProvider.remove(id);
		
	}

}
