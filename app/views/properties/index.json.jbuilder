json.array!(@properties) do |property|
  json.extract! property, :id, :title, :description, :photo, :price, :street_number, :street_name, :suite, :zipcode, :city, :state_id, :agent_id, :status
  json.url property_url(property, format: :json)
end
