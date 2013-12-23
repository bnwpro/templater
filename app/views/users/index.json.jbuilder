json.array!(@users) do |user|
  json.extract! user, :name, :date
  json.url user_url(user, format: :json)
end
