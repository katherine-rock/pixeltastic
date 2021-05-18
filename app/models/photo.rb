class Photo < ApplicationRecord
    validates :title, presence: true
    has_one :image
end
