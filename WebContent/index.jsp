<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SimpleTodo - Et nyttig verkt�y :)</title>
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
				<input type='checkbox' /><span class="todo-text"></span>
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
					console.log(data);
				}
			});

		});
	</script>
</body>
</html>