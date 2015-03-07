json.array!(@coords) do |coord|
  json.extract! coord, :id, :lat, :lng
  json.url coord_url(coord, format: :json)
end
