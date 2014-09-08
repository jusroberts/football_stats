json.array!(@stats) do |stat|
  json.extract! stat, :id, :url, :range
  json.url stat_url(stat, format: :json)
end
