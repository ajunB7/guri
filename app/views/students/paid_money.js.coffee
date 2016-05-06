$ ->
	$(".paid-<%= @student.id %>-<%= @month %>-<%= @year %>")[0].className = "btn paid-<%= @student.id %>-<%= @month %>-<%= @year %> btn-success active"
	$(".unpaid-<%= @student.id %>-<%= @month %>-<%= @year %>")[0].className = "btn unpaid-<%= @student.id %>-<%= @month %>-<%= @year %> btn-default"