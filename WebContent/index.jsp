<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SimpleTodo - Et enkelt verktøy :)</title>
<script type="text/javascript" src="lib/jquery-1.7.1.min.js"></script>

</head>
<body>
	<header>
		<h1>Todo liste er her igjen</h1>
	</header>
	<div>
		<div id="top-nav"></div>
		<div id="top-border"></div>

		<div class="new-todo-container">
			<input type='text' class="todo-text" />
			<input type='button' class="add-todo" value='Legg til' />
		</div>
		<div class="todos">
			<div class="todo-template" style="display: none">
				<input type='checkbox' class="todo-status" />
				<span class="todo-text"></span>
				<span class="todo-id" style="display:none"></span>
				<span class="todo-description" style="display:none"></span>
				<input type='button' class="delete-todo" value='Fjern'/>
			</div>
		</div>
        <div>
        	<input type="button" id="delete-checked" value="Fjern utførte" style="display:none" />
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
                        $clone.children('.todo-id').text(data[i].id);
                        $clone.children('.todo-description').text(data[i].description);
                        if (data[i].isDone)
                        {
                            $clone.children('input[type=checkbox]').attr('checked', true);
                        }
                        
                        $clone.appendTo('.todos').show();
                        
                        
                    }
		
					toggleDeleteChecked();
				}
			});
			
			
			$('input.add-todo').on('click', function (){
				
				var todoText = $('.new-todo-container .todo-text').val();
				$.ajax({
					url: "rest/todos",
					contentType: "application/json",
					type: "POST",
					data: '{"summary":"' + todoText + '"}',
					success: function(data, textStatus, jqXHR){
						var $clone = $('.todo-template').clone();
		                $clone.removeClass('todo-template').addClass('todo');
		                $clone.children('.todo-text').text(data.summary);
		                $clone.children('.todo-id').text(data.id);
		                $clone.children('.todo-description').text(data.description);
		                $clone.prependTo('.todos').show();
					}
				});
				
				$('.new-todo-container .todo-text').val('');
			});
			
			
		    $(document).on('change', '.todo-status', function(){
				var thisCheck = $(this);
				if (thisCheck.is(':checked')){
					thisCheck = true;
				} else {
					thisCheck = false;
				}
				
				var todoText = $(this).siblings('span.todo-text').text();
				var todoId =   $(this).siblings('span.todo-id').text();
				var todoDescription =   $(this).siblings('span.todo-description').text();
				
				$.ajax({
					
					url: "rest/todos" + "/" + todoId,
					contentType: "application/json",
					type: "PUT",
					data: '{"id":"' + todoId +'","summary":"' + todoText + '","description":"' + todoDescription +'", "isDone":"'+ thisCheck + '"}',
					success: function (data){
						console.log(data);
						toggleDeleteChecked()
					}
				});
				
				
			});
		    
		    
		    $(document).on('click', '.delete-todo', function(){
				var todoId = $(this).siblings('.todo-id').text();
				var todo = $(this).parent();
				$.ajax({
					
					url: "rest/todos" + "/" + todoId,
					contentType: "application/json",
					type: "DELETE",
					data: '{"id": "' + todoId + '"}',
					success: function (data){
						$(todo).remove();
						
						toggleDeleteChecked();
					}
				});
				
				
			});
		    
		    $(document).on('click', '#delete-checked', function(){
		    	var checkedTodos = $("INPUT[type='checkbox']").filter(':checked');
		    	var checkedTodoIds = checkedTodos.siblings('.todo-id');
		    	
		    	var ids = checkedTodoIds.map(function() {
		    	    return $(this).text();
		    	}).get();
		    	
		    	$.ajax({
		    		
		    		url: "rest/todos",
		    		contentType: "application/json",
		    		type: "DELETE",
		    		data: JSON.stringify(ids),
		    		success: function(data){
		    			checkedTodos.each(function(){
		    				$(this).parent().remove();
		    			});
		    			
		    			toggleDeleteChecked();
		    		}
		    	});
		    });
		    
		    
		    
		}); 
		
		
	
	
	
	
	function toggleDeleteChecked(){
		
		if($("INPUT[type='checkbox']").is(':checked')){
			$('#delete-checked').show();	
		}
		else {
			$('#delete-checked').hide();
		}	
	}
		
	</script>
	
		
</body>
</html>