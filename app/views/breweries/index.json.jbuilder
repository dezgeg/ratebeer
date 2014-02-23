json.array!(@breweries) do |brewery|
  json.extract! brewery, :id, :name, :year
  json.beers_count brewery.beers.count
end
