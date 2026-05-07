class Chat < ApplicationRecord
 
  belongs_to :user
  # class_name と foreign_key を両方指定するのがポイントです
  belongs_to :room, class_name: "Chatroom", foreign_key: "room_id"

  validates :message, presence: true, length: { maximum: 140 }

end
