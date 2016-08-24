json.extract! repository, :id, :repository_name, :description, :creation_date, :acess_count, :user_id, :created_at, :updated_at
json.url repository_url(repository, format: :json)