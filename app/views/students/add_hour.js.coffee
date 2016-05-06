$ ->
	# Hours Today
	$(".today-hours-<%= @student.id %>-<%= @day %>-<%= @month %>-<%= @year %>")[0].innerText = '<%= @hour.count %>'
	# Money Made Today
	$(".today-fee-<%= @student.id %>-<%= @day %>-<%= @month %>-<%= @year %>")[0].innerText = '$' + <%= @student.fee * @hour.count %>
	# Month Hours
	$(".total-hours-<%= @student.id %>-<%= @day %>-<%= @month %>-<%= @year %>")[0].innerText = parseFloat($(".total-hours-<%= @student.id %>-<%= @day %>-<%= @month %>-<%= @year %>")[0].innerText) + 1
	# Month Money Made
	console.log ".total-fee-<%= @student.id %>-<%= @day %>-<%= @month %>-<%= @year %>"
	$(".total-fee-<%= @student.id %>-<%= @day %>-<%= @month %>-<%= @year %>")[0].innerText = '$' + (<%= @student.fee %> + parseFloat($(".total-fee-<%= @student.id %>-<%= @day %>-<%= @month %>-<%= @year %>")[0].innerText.replace("$", "")))

	# Hours Today
	$(".total-today-hours-<%= @month %>-<%= @year %>")[0].innerText = 	parseFloat($(".total-today-hours-<%= @month %>-<%= @year %>")[0].innerText) + 1
	# Money Made Today
	$(".total-today-fee-<%= @month %>-<%= @year %>")[0].innerText =  	'$' + (parseFloat($(".total-today-fee-<%= @month %>-<%= @year %>")[0].innerText.replace("$", "")) + <%= @student.fee %>)
	# Month Hours
	$(".total-hours-<%= @month %>-<%= @year %>")[0].innerText =         (parseFloat($(".total-hours-<%= @month %>-<%= @year %>")[0].innerText) +  1)
	# Month Money Made
	$(".total-fee-<%= @month %>-<%= @year %>")[0].innerText =  			'$' + (parseFloat($(".total-fee-<%= @month %>-<%= @year %>")[0].innerText.replace("$", "")) + <%= @student.fee %>)

	$(".student-<%= @student.id %>")[0].style.backgroundColor = "#B4DCB3"