json.extract! photo, :id, :title, :description, :price, :category, :style, :created_at, :updated_at
json.url photo_url(photo, format: :json)