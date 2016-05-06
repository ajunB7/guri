$ ->
	$(".unpaid-<%= @student.id %>-<%= @month %>-<%= @year %>")[0].className = "btn unpaid-<%= @student.id %>-<%= @month %>-<%= @year %> btn-danger active"
	$(".paid-<%= @student.id %>-<%= @month %>-<%= @year %>")[0].className = "btn paid-<%= @student.id %>-<%= @month %>-<%= @year %> btn-default"