json.array!(@parts) do |part|
  json.extract! part, :id, :leter, :nro, :title, :reference, :model_id
  json.url part_url(part, format: :json)
end
