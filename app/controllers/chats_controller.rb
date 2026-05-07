class ChatsController < ApplicationController
  before_action :reject_non_related, only: [:show]


 def show
 @user = User.find(params[:id])
 rooms = Current.user.user_rooms.pluck(:room_id)
 user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
  if user_rooms.nil?
      rooms = Current.user.user_rooms.pluck(:room_id) 
      # 10行目付近
      @room = Chatroom.new # rは小文字
      @room.save
      UserRoom.create(user_id: Current.user.id, room_id: @room.id) 
      UserRoom.create(user_id: @user.id, room_id: @room.id)
  else
     @room = user_rooms.room
  end

 @chats = Chat.where(room_id: @room.id)
 @chat = Chat.new(room_id: @room.id)
 end

 def create
  @chat = Current.user.chats.new(chat_params)
  @chat.save
  redirect_to chat_path(@chat.room.user_rooms.where.not(user_id: Current.user.id).first.user_id)
 end

 private

 def chat_params
  params.require(:chat).permit(:message, :room_id)
 end

 def reject_non_related
    user = User.find(params[:id])
    unless Current.user.following?(user) && user.following?(Current.user)
        redirect_to books_path
    end
  end 
end


