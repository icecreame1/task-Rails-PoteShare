class Room < ApplicationRecord
  attachment :room_image
  attachment :user_image

  belongs_to :user
  has_many :reservations, dependent: :destroy

  with_options presence: true do
    validates :room_name
    validates :room_introduction
    validates :price
    validates :address
    validates :room_image
  end
end
