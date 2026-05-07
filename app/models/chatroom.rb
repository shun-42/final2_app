class Chatroom < ApplicationRecord
  has_many :user_rooms
  # ここにも foreign_key を指定します
  has_many :chats, foreign_key: "room_id", dependent: :destroy
end
