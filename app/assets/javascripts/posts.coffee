# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# autosize($('textarea'))

canvas = undefined
context2D = undefined
particles = []

randomFloat = (min, max) ->
	min + Math.random() * (max - min)
# A single explosion particle

Particle = ->
	@scale = 1.0
	@x = 0
	@y = 0
	@radius = 20
	@color = '#000'
	@velocityX = 0
	@velocityY = 0
	@scaleSpeed = 0.5

	@update = (ms) ->
		# shrinking
		@scale -= @scaleSpeed * ms / 1000.0
		if @scale <= 0
			@scale = 0
		# moving away from explosion center
		@x += @velocityX * ms / 1000.0
		@y += @velocityY * ms / 1000.0
		return

	@draw = (context2D) ->
		# translating the 2D context to the particle coordinates
		context2D.save()
		context2D.translate @x, @y
		context2D.scale @scale, @scale
		# drawing a filled circle in the particle's local space
		context2D.beginPath()
		context2D.arc 0, 0, @radius, 0, Math.PI * 2, true
		context2D.closePath()
		context2D.fillStyle = @color
		context2D.fill()
		context2D.restore()
		return

	return

###
# Advanced Explosion effect
# Each particle has a different size, move speed and scale speed.
#
# Parameters:
# 	x, y - explosion center
# 	color - particles' color
###

createExplosion = (x, y, color) ->
	minSize = 3
	maxSize = 6
	count = 10
	minSpeed = 60.0
	maxSpeed = 200.0
	minScaleSpeed = 1.0
	maxScaleSpeed = 4.0
	angle = 0
	while angle < 360
		particle = new Particle
		particle.x = x
		particle.y = y
		particle.radius = randomFloat(minSize, maxSize)
		particle.color = color
		particle.scaleSpeed = randomFloat(minScaleSpeed, maxScaleSpeed)
		speed = randomFloat(minSpeed, maxSpeed)
		particle.velocityX = speed * Math.cos(angle * Math.PI / 180.0)
		particle.velocityY = speed * Math.sin(angle * Math.PI / 180.0)
		particles.push particle
		angle += Math.round(360 / count)
	return

update = (frameDelay) ->
	# draw a white background to clear canvas
	context2D.fillStyle = '#FFF'
	context2D.fillRect 0, 0, context2D.canvas.width, context2D.canvas.height
	# update and draw particles
	i = 0
	while i < particles.length
		particle = particles[i]
		particle.update frameDelay
		particle.draw context2D
		i++
	return



explode = (id) ->
	canvas = document.getElementById('canvas_'+id)
	context2D = canvas.getContext('2d')
	# Button click : BOOM !
	x = canvas.width/2
	y = canvas.height/2
	createExplosion x, y, '#81EAC3'
	createExplosion x, y, '#8FD2F9'
	createExplosion x, y, '#CF8AEF'
	createExplosion x, y, '#F5849C'

	# starting the game loop at 60 frames per second


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

	frameRate = 60.0
	frameDelay = 1000.0 / frameRate
	setInterval ->
		update frameDelay
	, frameDelay
		# canvas = document.getElementById('canvas')
		# context2D = canvas.getContext('2d')
		# Button click : BOOM !
		# $('#explosion').on 'click', ->
		# 	x = canvas.width/2
		# 	y = canvas.height/2
		# 	createExplosion x, y, '#81EAC3'
		# 	createExplosion x, y, '#8FD2F9'
		# 	createExplosion x, y, '#CF8AEF'
		# 	createExplosion x, y, '#F5849C'
		# 	return
		# starting the game loop at 60 frames per second
		#
