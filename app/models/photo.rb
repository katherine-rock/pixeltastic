class Photo < ApplicationRecord
    validates :title, :image, :price, presence: true
    has_one_attached :image
end
