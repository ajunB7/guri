json.array!(@student_extrafees) do |student_extrafee|
  json.extract! student_extrafee, :id, :name, :price
  json.url student_extrafee_url(student_extrafee, format: :json)
end
