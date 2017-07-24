json.extract! question, :id, :name, :category_id, :created_at, :updated_at
json.url question_url(question, format: :json)
