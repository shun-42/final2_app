class ChatsController < ApplicationController
  before_action :follow_each_other, only: [:show]
  def show
    @user = User.find(params[:id])
    rooms = Current.user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
      UserRoom.create(user_id: Current.user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end
  def create
    @chat = Current.user.chats.new(chat_params)
    if @chat.save
      @new_chat = Chat.new(room_id: @chat.room_id)
    else
      @new_chat = @chat
    end
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to request.referrer }
    end

  end

  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def follow_each_other
    user = User.find(params[:id])
    unless Current.user.following?(user) && user.following?(Current.user)
      redirect_to user_path(user)
    end
  end
end



