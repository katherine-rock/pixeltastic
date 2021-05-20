class Photo < ApplicationRecord
    validates :title, :image, :price, presence: true
    has_one_attached :image
    belongs_to :user
end
