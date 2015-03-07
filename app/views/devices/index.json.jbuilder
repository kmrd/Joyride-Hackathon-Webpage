json.array!(@devices) do |device|
  json.extract! device, :id, :name, :user_id
  json.url device_url(device, format: :json)
end
