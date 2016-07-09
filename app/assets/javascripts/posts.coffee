# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# autosize($('textarea'))

@like = (e, id) ->
	url = ['/posts/', id, '/uplike'].join('')
	$.ajax
		type: 'PUT'
		url: url
		dataType: 'json'
		success: (xhr, status, response) ->
			data = JSON.parse response.responseText
			img_src = $(e).find('img').attr('src')
			$('#like_count_'+id).html data.like
			$(e).append('<img src=' + img_src + ' class=\'heart__float\'/>')
			$('.heart__float').animate {top: -60, opacity: '0'}, {duration: 1200, queue: false}, 'swing'
			$('.heart__float').animate {left: -15}, {duration: 500, queue: false}, 'swing'
			setTimeout ->
				$('.heart__float').animate {left: 15}, {duration: 500}, 'swing'
			, 500
			setTimeout ->
				$('.heart__float').remove();
			, 1200
	return false

$ ->
	simplemde = new SimpleMDE {
		element: $('#post_content')[0],
		placeholder: 'Write post here',
		toolbar: false,
		status: [{
			className: 'guide'
			defaultValue: (el) ->
				el.innerHTML = '<b>**bold**</b>&nbsp;&nbsp;<i>_Italics_</i>&nbsp;&nbsp;>quote&nbsp;&nbsp;![images]()&nbsp; &nbsp;[links]()'
			}, 'words']
	}
