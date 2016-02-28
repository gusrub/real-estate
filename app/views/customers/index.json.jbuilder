json.array!(@customers) do |customer|
  json.extract! customer, :id, :title, :phone, :mobile, :user_id
  json.url customer_url(customer, format: :json)
end
