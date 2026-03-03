json.extract! reservation_room, :id, :date, :user_id, :room_id, :created_at, :updated_at
json.url reservation_room_url(reservation_room, format: :json)
