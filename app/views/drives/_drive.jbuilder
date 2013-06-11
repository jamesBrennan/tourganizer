json.(drive, :id, :distance_matrix)

json.origin do
  json.id drive.origin.id
  json.location drive.origin.location
end

json.destination do
  json.id drive.origin.id
  json.location drive.destination.location
end
