var ajax = (function() {
	
    var _baseUrl = "";
    
    var setBaseUrl = function(baseUrl){
    	_baseUrl = baseUrl;
    };
    
    var doAjax = function(settings) {
		$.ajax({
			url : settings.url || _baseUrl,
			type : settings.type || "GET",
			contentType : "application/json",
			dataType : "json",
			data : settings.data,
			success : settings.success,
			error : function(jqXHR, textStatus, errorThrown) {
				$('.error-message').text("Det oppstod en feil på serveren")
						.show();
			}
		});
	};

	var get = function(settings) {
		settings.type = "GET";
		doAjax(settings);
	};
	
	var post = function(settings) {
		settings.type = "POST";
		doAjax(settings);
	};
	
	var put = function(path, settings)
	{
		settings.type = "PUT";
		settings.url = _baseUrl + "/" + path;
		doAjax(settings);
	};
	
	var remove = function(todoId, settings)
	{
		settings.type = "DELETE";
		settings.url = _baseUrl + "/" + todoId;
		doAjax(settings);
	};
	
	var removeAll = function (settings)
	{
		settings.type = "DELETE";
		doAjax(settings);
	};

	// Interface
	return {
		setBaseUrl: setBaseUrl,
		get: get,
		post: post,
		put: put,
		remove: remove,
		removeAll: removeAll
	};
}());