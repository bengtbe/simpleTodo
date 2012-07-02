<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>SimpleTodo - Et nyttig verkt�y :)</title>
	<script type="text/javascript" src="lib/jquery-1.7.1.min.js"></script>
</head>
<body>
	<h1>Todo liste er her</h1>	
	<script type="text/javascript">
	$(function(){
		$.ajax({
			url: "rest/todos",
			dataType: "json",
			success: function(data, textStatus, jqXHR){
				console.log(data);
			}
		});
		
	});
	</script>
</body>
</html>