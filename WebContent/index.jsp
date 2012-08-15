<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SimpleTodo - Et enkelt verktøy :)</title>

<link rel="stylesheet" href="css/style.css">
<script type="text/javascript" src="lib/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="lib/jquery-ui-1.8.22.custom.min.js"></script>
<script type="text/javascript" src="lib/simpletodo.js"></script>
<script type="text/javascript" src="lib/simpletodo-ajax.js"></script>

</head>
<body>
	<div class="error-message" style="display:none"></div>
	<div id="todo-list">
		<div id="todo-heading"><h2>Siws Todo</h2></div>
		<div class="new-todo-container">
			<input type='text' class="todo-text" />
		</div>
		<div class='todos-sortable-container'>
			<div class='todos'>
				<div class="todo-template" style="display: none">
					<div class='todo'>
						<input type='checkbox' class='todo-status' /> 
						<span class='todo-text'></span>
						<input type='hidden' class='todo-description'/>
						<input type='button' class='delete-todo' value='Fjern' />
					</div>
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

			ajax.setBaseUrl("rest/todos");
			
			ajax.get({
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
						
						ajax.post({
							data : '{"summary":"' + todoText + '"}',
							success : function(data, textStatus, jqXHR) {
								createTodo(data).appendTo('.todos');
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
				var todoText = $todo.find('.todo-text').text();
				var todoId = $todo.data('id'); 
				var todoDescription = $todo.find('.todo-description').text();

				ajax.put(todoId, {
					data : '{"id":"' + todoId 
							+ '","summary":"' + todoText
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
				
				ajax.remove (todoId, {
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

						ajax.removeAll({
							data : JSON.stringify(ids),
							success : function(data) {
								checkedTodos.each(function() {
									$(this).remove();
								});

								toggleDeleteChecked();
								$('.error-message').hide();
								
							},
						});
					});
			
			
			$(function() {
				$( ".todos" ).sortable({ 
					axis: 'y',  
					containment: '.todos-sortable-container',
					update: function(){
						var ids = $(this).find('.todo').map(function() {
							return $(this).data('id');
						}).get();
						
						ajax.put("sort", {
							data: JSON.stringify(ids),
							success: function(data){
								console.log(data);
							}
						});
						
					}
				});
				//$( ".todos" ).disableSelection();
			});
			
			
			
			
			$(document).on('click', '.todos .todo-text', function(){
				console.log('Klick klack');
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
		
		var doAjax = function(settings){
			
			$.ajax({
				url : settings.url,
				type: settings.type || "GET",
				contentType : "application/json",
				dataType : "json",
				data: settings.data,
				success: settings.success,
				error: function(jqXHR, textStatus, errorThrown){
					$('.error-message').text("Det oppstod en feil på serveren").show();
				}
			});
		}
		
		
		
	</script>


</body>
</html>