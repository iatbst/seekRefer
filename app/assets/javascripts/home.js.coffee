# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('.hover').bind 'click', (event) ->
		city = $(this).text()
		#console.log(content.trim())
		window.location.href = "/region_page/index?city=" + city.trim()	
