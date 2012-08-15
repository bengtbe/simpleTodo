package de.vogella.jersey.todo.resources;

import java.io.Console;
import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Request;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

import de.vogella.jersey.todo.dao.TodoDao;
import de.vogella.jersey.todo.model.Todo;

//Will map the resource to the URL todos
@Path("/todos")
public class TodosResource {

	// Allows to insert contextual objects into the class,
	// e.g. ServletContext, Request, Response, UriInfo
	@Context
	UriInfo uriInfo;
	@Context
	Request request;

	// Return the list of todos to the user in the browser
	@GET
	@Produces(MediaType.TEXT_XML)
	public List<Todo> getTodosBrowser() {
		
		return TodoDao.instance.getTodos();
	}

	// Return the list of todos for applications
	@GET
	@Produces({ MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON })
	public List<Todo> getTodos() {
		
		return TodoDao.instance.getTodos();
	}

	// Returns the number of todos
	// Use http://localhost:8080/de.vogella.jersey.todo/rest/todos/count
	// to get the total number of records
	@GET
	@Path("count")
	@Produces(MediaType.TEXT_PLAIN)
	public String getCount() {
		int count = TodoDao.instance.getTodos().size();
		return String.valueOf(count);
	}

//	@POST
//	@Produces(MediaType.TEXT_HTML)
//	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
//	public void newTodo(@FormParam("id") String id,
//			@FormParam("summary") String summary,
//			@FormParam("description") String description,
//			@Context HttpServletResponse servletResponse) throws IOException {
//		Todo todo = new Todo(id, summary);
//		if (description != null) {
//			todo.setDescription(description);
//		}
//		TodoDao.instance.getTodos().put(id, todo);
//
//		servletResponse.sendRedirect("../create_todo.html");
//	}

	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response newTodo(Todo todo) {
		
		Response res;
		
		if (TodoDao.instance.containsTodo(todo.getId())) {
			res = Response.noContent().build();
		} else {
			//res = Response.created(uriInfo.getAbsolutePath()).build();
			res = Response.created(uriInfo.getAbsolutePath()).entity(todo).build();
		}
		
		TodoDao.instance.addTodo(todo);
		return res;
	}
	
	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	@Path("sort")
	public void sortTodos(String[] ids){
		int order = 1;
		for (String id: ids){
			Todo todo = TodoDao.instance.getTodo(id);
			todo.setOrder(order++);
		}
	}
	
	
	@DELETE
	@Consumes(MediaType.APPLICATION_JSON)
	public void deleteTodos(String [] ids) throws Exception
	{

		for (String id: ids){
			TodoDao.instance.deleteTodo(id);
		}
	}
	
	
	// Defines that the next path parameter after todos is
	// treated as a parameter and passed to the TodoResources
	// Allows to type http://localhost:8080/de.vogella.jersey.todo/rest/todos/1
	// 1 will be treaded as parameter todo and passed to TodoResource
	@Path("{id}")
	public TodoResource getTodo(@PathParam("id") String id) {
		return new TodoResource(uriInfo, request, id);
	}
}
