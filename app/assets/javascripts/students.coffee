# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	for studentHours in $(".today-hours")
		if studentHours.innerText != "0"
			studentHours.parentElement.style.backgroundColor = "#f2f7f4"

