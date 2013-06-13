json.array!(@drives) do |json, drive|
  json.partial! 'drives/drive', drive: drive
end
