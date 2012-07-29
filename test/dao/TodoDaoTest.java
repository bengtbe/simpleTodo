package dao;

import static org.junit.Assert.*;
import junit.framework.Assert;

import org.junit.Before;
import org.junit.Test;

import de.vogella.jersey.todo.dao.TodoDao;
import de.vogella.jersey.todo.model.Todo;

public class TodoDaoTest {
	
	private TodoDao todos;


	@Before
	public void setUp() {
		todos = TodoDao.instance;
		todos.getTodos().clear();
	}
	
	
	@Test
	public void deleteTodo_OneItemInList_ItShouldBeRemoved() {

		Todo todo = addTodo();
		
		todos.deleteTodo(todo.getId());
		
		assertEquals(0, todos.getTodos().size());
	}
	
	@Test
	public void addTodo_AddTwoTodosDeleteTheFirstAddAThird_TodosShouldHaveUniqueIds(){
		
		Todo todo1 = addTodo();
		Todo todo2 = addTodo();
		todos.deleteTodo(todo1.getId());
		
		Todo todo3 = addTodo();
		
		assertFalse(todo2.getId().equals(todo3.getId()));
	}


	private Todo addTodo() {
		Todo todo = new Todo();
		todos.addTodo(todo);
		return todo;
	}

}
