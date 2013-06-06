json.stops do
  json.array!(@stops) do |json, stop|
    json.partial! 'stops/_stop', stop: stop
  end
end
