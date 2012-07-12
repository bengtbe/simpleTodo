<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SimpleTodo - Et nyttig verktøy :)</title>
<script type="text/javascript" src="lib/jquery-1.7.1.min.js"></script>
</head>
<body>
	<header>
		<h1>Todo liste er her igjen</h1>
	</header>
	<div>
		<div id="top_nav"></div>
		<div id="top_border"></div>

		<div class="add_todo">
			<input type='text' class="new_todo" /><input type='button'
				onclick="addTodo()" value='Legg til' />
		</div>
		<div class="todos">
			<div class="todo-template" style="display: none">
				<input type='checkbox' class="todo_status" />
				<span class="todo-text"></span>
				<span class="todo_id" style="display:none"></span>
				<span class="todo_description" style="display:none"></span>
			</div>
		</div>
	</div>

	<footer> </footer>

	<script type="text/javascript">
		$(function() {
			
			$.ajax({
				url : "rest/todos",
				dataType : "json",
				success : function(data, textStatus, jqXHR) {
					for (i in data)
                    {
                        var $clone = $('.todo-template').clone();
                        $clone.removeClass('todo-template').addClass('todo');
                        $clone.children('.todo-text').text(data[i].summary);
                        $clone.children('.todo_id').text(data[i].id);
                        $clone.children('.todo_description').text(data[i].description);
                        if (data[i].isDone)
                        {
                            $clone.children('input[type=checkbox]').attr('checked', true);
                        }
                        $clone.appendTo('.todos').show();
                    }

				}
			});
			
		    $(document).on('change', '.todo_status', function(){
		    	
				alert("Hei");
				var thisCheck = $(this);
				if (thisCheck.is(':checked')){
					thisCheck = true;
				} else {
					thisCheck = false;
				}
				
				var todoText = $(this).siblings('span.todo-text').text();
				var todoId =   $(this).siblings('span.todo_id').text();
				var todoDescription =   $(this).siblings('span.todo_description').text();
				
				$.ajax({
					
					url: "rest/todos" + "/" + todoId,
					contentType: "application/json",
					type: "PUT",
					data: '{"id":"' + todoId +'","summary":"' + todoText + '","description":"' + todoDescription +'", "isDone":"'+ thisCheck + '"}',
					success: function (data){
						console.log(data);
					}
				});
			});
		}); 
	
	function addTodo(){
		
		var todoText = $('.new_todo').val();
		$.ajax({
			url: "rest/todos",
			contentType: "application/json",
			type: "POST",
			data: '{"summary":"' + todoText + '"}',
			success: function(data, textStatus, jqXHR){
				console.log(data);
			}
		});
	}
	
	
		
	</script>
	
		
</body>
</html>