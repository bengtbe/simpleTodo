package de.vogella.jersey.todo.dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import de.vogella.jersey.todo.model.Todo;

public enum TodoDao {
	instance;

	private Map<String, Todo> contentProvider = new HashMap<String, Todo>();
	private int nextId = 1;

	
	private TodoDao() {

		Todo todo = new Todo("Learn REST", true);
		todo.setDescription("Read http://www.vogella.com/articles/REST/article.html");
		todo.setOrder(1);
		addTodo(todo);
		todo = new Todo("Do something", false);
		todo.setDescription("Read complete http://www.vogella.com");
		todo.setOrder(2);
		addTodo(todo);

	}

	public void Clear(){
		contentProvider.clear();
	}
	
	public List<Todo> getTodos() {
				
		ArrayList<Todo> arrayList = new ArrayList<Todo>(contentProvider.values());
		
		Collections.sort(arrayList, new Comparator<Todo>() {
		    public int compare(Todo a, Todo b) {
		        return a.getOrder() - b.getOrder();
		    }
		});
		
		return arrayList;
	}
	
	public Todo getTodo(String id) {
		
		return contentProvider.get(id);
	}
	
	public boolean containsTodo(String id){
		return contentProvider.containsKey(id);
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
		
		todo.setOrder(contentProvider.size() + 1);
		
		contentProvider.put(todo.getId(), todo);
	}

	public void deleteTodo(String id) {
		contentProvider.remove(id);
	}
	
	
}