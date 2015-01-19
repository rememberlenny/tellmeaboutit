json.array!(@recordings) do |recording|
  json.extract! recording, :id, :url, :length, :transcript, :twilio_id
  json.url recording_url(recording, format: :json)
end
