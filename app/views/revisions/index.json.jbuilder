json.array!(@revisions) do |revision|
  json.extract! revision, :id, :autor, :nro, :fecha, :state_id, :part_id
  json.url revision_url(revision, format: :json)
end
