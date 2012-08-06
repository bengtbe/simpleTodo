<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SimpleTodo - Et enkelt verktøy :)</title>

<link rel="stylesheet" href="css/style.css">
<script type="text/javascript" src="lib/jquery-1.7.1.min.js"></script>

</head>
<body>
	<header>
		<h1>Todo liste er her igjen</h1>
	</header>
	<div class="error-message" style="display:none"></div>
	<div id="todo-list">
		<div id="todo-heading"><h2>Siws Todo</h2></div>
		<div class="new-todo-container">
			<input type='text' class="todo-text" />
		</div>
		<div class="todos">
			<div class="todo-template" style="display: none">
				<div class='todo'>
					<!-- <input type='hidden' class='todo-id'/> -->
					<input type='checkbox' class='todo-status' /> 
					<span class='todo-text'></span>
					<input type='hidden' class='todo-description'/>
					<input type='button' class='delete-todo' value='Fjern' />
				</div>
			</div>
		</div>
		<div>
			<input type="button" id="delete-checked" value="Fjern utførte" style="display: none" />
		</div>
	</div>

	<footer> </footer>

	<script type="text/javascript">
		$(function() {

			$.ajax({
				url : "rest/todos",
				dataType : "json",
				success : function(data, textStatus, jqXHR) {
					for (i in data) {
						createTodo(data[i]).appendTo('.todos');
					}

					toggleDeleteChecked();
					$('.error-message').hide();
				}
			});

			
			
			$('input.todo-text').on('keyup', function(key){
				if (key.keyCode == 13){
					
					if( $(this).val().trim() ){ 
					
						var todoText = $(this).val();
						
						$.ajax({
							url : "rest/todos",
							contentType : "application/json",
							type : "POST",
							data : '{"summary":"' + todoText + '"}',
							success : function(data, textStatus, jqXHR) {
								createTodo(data).prependTo('.todos');
								$('.error-message').hide();
							}
							
						});
	
						
					}
					
					$('.new-todo-container .todo-text').val('');
				}
			});

			$(document).on('change', '.todo-status', function() {
						
				var $todo = $(this).parents(".todo");
				var thisCheck = $(this).is(':checked');
				var $todoText = $(this).siblings('todo-text');
				var todoId = $todo.data('id'); 
				var todoDescription = $(this).siblings('.todo-description').text();

				$.ajax({

					url : "rest/todos" + "/" + todoId,
					contentType : "application/json",
					type : "PUT",
					data : '{"id":"' + todoId 
							+ '","summary":"' + $todoText.text() 
							+ '","description":"' + todoDescription 
							+ '", "isDone":"' + thisCheck + '"}',
					success : function(data) {
						console.log(data);
						toggleDeleteChecked();
						
						$todo.toggleClass("checked-todo", thisCheck);
						$('.error-message').hide();
					}
				});

			});

			$(document).on('click', '.delete-todo', function() {
				
				var $todo = $(this).parents(".todo");	
				var todoId = $todo.data('id'); 
				
				$.ajax({

					url : "rest/todos" + "/" + todoId,
					contentType : "application/json",
					type : "DELETE",
					data : '{"id": "' + todoId + '"}',
					success : function(data) {
						$todo.remove();
						toggleDeleteChecked();
						$('.error-message').hide();
					}
				});

			});

			$(document).on('click',	'#delete-checked',	function() {
						var checkedCheckboxes = $("INPUT[type='checkbox']").filter(':checked');
						
						var checkedTodos = checkedCheckboxes.parents('.todo');
						
						var ids = checkedTodos.map(function() {
							return $(this).data('id');
						}).get();

						$.ajax({

							url : "rest/todos",
							contentType : "application/json",
							type : "DELETE",
							data : JSON.stringify(ids),
							success : function(data) {
								checkedTodos.each(function() {
									$(this).remove();
								});

								toggleDeleteChecked();
								$('.error-message').hide();
								
							},
							error: function(jqXHR, textStatus, errorThrown){
								$('.error-message').text("Det oppstod en feil på serveren").show();
							}
						});
					});

		});

		function createTodo(data) {

			var $clone = $($('.todo-template').html());

			$clone.children('.todo-text').text(data.summary);
			$clone.data('id', data.id);
			$clone.children('.todo-description').text(data.description);

			if (data.isDone) {
				$clone.children('input[type=checkbox]').attr('checked', true);
				$clone.addClass("checked-todo");
			}
			
			return $clone;
		}

		function toggleDeleteChecked() {

			if ($("INPUT[type='checkbox']").is(':checked')) {
				$('#delete-checked').show();
			} else {
				$('#delete-checked').hide();
			}
		}
	</script>


</body>
</html>