json.extract! echogram_temp, :id, :echogram_name, :image_filename, :frequency, :haul_id, :user_id, :latitude, :longitude, :created_at, :updated_at
json.url echogram_temp_url(echogram_temp, format: :json)
