json.array!(@stops) do |json, stop|
  json.partial! 'stops/stop', stop: stop
end
