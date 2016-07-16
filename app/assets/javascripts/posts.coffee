# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@like = (e, id) ->
	url = ['/articles/', id, '/uplike'].join('')
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
	return

$ ->
	if $('#post_content').length
		simplemde = new SimpleMDE {
			element: document.getElementById('post_content'),
			placeholder: 'Write post here',
			toolbar: false,
			status: [{
				className: 'guide'
				defaultValue: (el) ->
					el.innerHTML = '<b>**bold**</b>&nbsp;&nbsp;<i>_Italics_</i>&nbsp;&nbsp;>quote&nbsp;&nbsp;![images]()&nbsp; &nbsp;[links]()'
				}, 'words']
		}

	if $('.dropzone').length
		Dropzone.autoDiscover = false
		dropzone = new Dropzone '.dropzone', {
			maxFilesize: 256,
			paramName: 'upload[image]',
			addRemoveLinks: false,
			dictDefaultMessage: 'Upload image'
		}

		dropzone.on 'complete', (file, response) ->
			this.removeFile(file)
			$.getScript('/gallery')
			$(window).reload

	timer = null
	$(document).on 'turbolinks:load', ->
		clearInterval(timer)
		timer = setTimeout ->
			$('.alert').fadeOut ->
				$(this).remove()
		, 2000

	# hoverMenuArray = [
	# 	'.posts.new aside.actions',
	# 	'.posts.edit aside.actions',
	# 	'.posts.new .masthead',
	# 	'.posts.edit .masthead'
	# ]
	# hoverMenu = hoverMenuArray.join(',')
	#
	# $(hoverMenu).hide()
	# $(window).on 'mousemove', ->
	# 	clearInterval(timer)
	# 	$(hoverMenu).fadeIn()
	# 	timer = setTimeout ->
	# 		$(hoverMenu).fadeOut()
	# 	, 2000
