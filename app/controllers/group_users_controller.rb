class GroupUsersController < ApplicationController
  def create
    group = Group.find(params[:group_id])
    group.users << Current.user
    redirect_to request.referer
  end

  def destroy
  # ログインユーザーが、このグループに参加しているデータを見つける
  group_user = Current.user.group_users.find_by(group_id: params[:group_id])
  # もしデータがあれば削除する
  group_user.destroy if group_user
  redirect_to request.referer
end
end
