package dao;

import static org.junit.Assert.*;

import java.util.List;
import java.util.Map;

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
		todos.Clear();
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
	
	@Test
	public void getTodos_AddThreeTodosInRandomOrder_TodosShouldBeSorted(){
		Todo todo1 = addTodo();
		Todo todo2 = addTodo();
		Todo todo3 = addTodo();
		
		todo1.setOrder(2);
		todo2.setOrder(3);
		todo3.setOrder(1);
		
		List<Todo> todoArray = todos.getTodos();
	
		
		assertEquals(todo3, todoArray.get(0));
		assertEquals(todo1, todoArray.get(1));
		assertEquals(todo2, todoArray.get(2));
		
	}
	
	@Test
	public void addTodo_AddOneTodo_ShouldGetOrderOne(){
		
		Todo todo1 = addTodo();
		
		assertEquals(1, todo1.getOrder());
	}

	@Test
	public void addTodo_AddTwoTodos_FirstShouldOrderOneSecondShouldGetOrderTwo(){
		
		Todo todo1 = addTodo();
		Todo todo2 = addTodo();
		
		assertEquals(1, todo1.getOrder());
		assertEquals(2, todo2.getOrder());
	}

	

	private Todo addTodo() {
		Todo todo = new Todo();
		todos.addTodo(todo);
		return todo;
	}

}
