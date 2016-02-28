json.array!(@users) do |user|
  json.extract! user, :id, :email, :password_digest, :first_name, :last_name, :role, :status
  json.url user_url(user, format: :json)
end
