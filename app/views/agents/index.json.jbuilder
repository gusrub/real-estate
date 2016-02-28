json.array!(@agents) do |agent|
  json.extract! agent, :id, :comission, :phone, :mobile, :user_id
  json.url agent_url(agent, format: :json)
end
