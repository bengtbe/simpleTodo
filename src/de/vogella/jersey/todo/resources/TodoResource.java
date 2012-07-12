package de.vogella.jersey.todo.resources;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Request;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;
import javax.xml.bind.JAXBElement;

import de.vogella.jersey.todo.dao.TodoDao;
import de.vogella.jersey.todo.model.Todo;

public class TodoResource {

	@Context
	UriInfo uriInfo;
	@Context
	Request request;
	String id;

	public TodoResource(UriInfo uriInfo, Request request, String id) {
		super();
		this.uriInfo = uriInfo;
		this.request = request;
		this.id = id;
	}

	// Application integration
	@GET
	@Produces({ MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON })
	public Todo getTodo() {
		Todo todo = TodoDao.instance.getTodos().get(id);
		if (todo == null) {
			throw new RuntimeException("Get: Todo with " + id + " not found");
		}
		return todo;
	}

	// For the browser
	@GET
	@Produces(MediaType.TEXT_XML)
	public Todo getTodoHTML() {
		Todo todo = TodoDao.instance.getTodos().get(id);
		if (todo == null)
			throw new RuntimeException("Get: Todo with " + id + " not found");
		return todo;
	}


	@DELETE
	public void deleteTodo() {
		Todo c = TodoDao.instance.getTodos().remove(id);
		if (c == null)
			throw new RuntimeException("Delete: Todo with " + id + " not found");
	}
	
	@PUT
	@Consumes(MediaType.APPLICATION_JSON)	
	public Response updateTodo(Todo todo){
		TodoDao.instance.updateTodo(todo);
		return Response.ok().build();
	}

}
