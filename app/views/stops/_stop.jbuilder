json.(stop, :id, :date, :location, :venues)

if stop.drive
  json.drive stop.drive
end
