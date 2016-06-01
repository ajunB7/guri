# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	for studentHours in $(".today-hours")
		if studentHours.innerText != "0"
			studentHours.parentElement.style.backgroundColor = "#B4DCB3"
jQuery ->
	$('.attended-students').click ->
		for studentHours in $(".today-hours")
			if studentHours.innerText == "0"
				studentHours.parentElement.className = "hidden"
			else
				studentHours.parentElement.className = ""
	$('.absent-students').click ->
		console.log "goes"
		for studentHours in $(".today-hours")
			if studentHours.innerText != "0"
				studentHours.parentElement.className = "hidden"
			else
				studentHours.parentElement.className = ""
	$('.all-students').click ->
		for studentHours in $(".today-hours")
			studentHours.parentElement.className = ""
	$('table').stickyTableHeaders()
