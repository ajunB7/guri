$ ->
	<% unless @hour.nil? %>
	# Hours Today
	$(".today-hours-<%= @student.id %>-<%= @day %>-<%= @month %>-<%= @year %>")[0].innerText = 0
	# Money Made Today
	$(".today-fee-<%= @student.id %>-<%= @day %>-<%= @month %>-<%= @year %>")[0].innerText = '$0'
	# Month Hours
	$(".total-hours-<%= @student.id %>-<%= @day %>-<%= @month %>-<%= @year %>")[0].innerText = parseFloat($(".total-hours-<%= @student.id %>-<%= @day %>-<%= @month %>-<%= @year %>")[0].innerText) - <%= @hour.count %>
	# Month Money Made
	$(".total-fee-<%= @student.id %>-<%= @day %>-<%= @month %>-<%= @year %>")[0].innerText = '$' + ((parseFloat($(".total-fee-<%= @student.id %>-<%= @day %>-<%= @month %>-<%= @year %>")[0].innerText.replace("$", ""))) - <%= @student.fee * @hour.count %>)

	# Hours Today
	$(".total-today-hours-<%= @month %>-<%= @year %>")[0].innerText = 	parseFloat($(".total-today-hours-<%= @month %>-<%= @year %>")[0].innerText) - <%= @hour.count %>
	# Money Made Today
	$(".total-today-fee-<%= @month %>-<%= @year %>")[0].innerText =  	'$' + (parseFloat($(".total-today-fee-<%= @month %>-<%= @year %>")[0].innerText.replace("$", "")) - <%= @student.fee * @hour.count %>)
	# Month Hours
	$(".total-hours-<%= @month %>-<%= @year %>")[0].innerText =         (parseFloat($(".total-hours-<%= @month %>-<%= @year %>")[0].innerText) -  <%= @hour.count %>)
	# Month Money Made
	$(".total-fee-<%= @month %>-<%= @year %>")[0].innerText =  			'$' + (parseFloat($(".total-fee-<%= @month %>-<%= @year %>")[0].innerText.replace("$", "")) - <%= @student.fee * @hour.count %>)

	$(".student-<%= @student.id %>")[0].style.backgroundColor = "#f9f9f9"
	<% end %>