class GroupsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def new
    @group = Group.new
  end


  def index
    @groups = Group.all
    @book = Book.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = Current.user.id
    @group.users << Current.user
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path, notice: "グループを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path, notice: "グループを削除しました。"
  end

  def show
    @group = Group.find(params[:id])
  end

  private

  def group_params
   params.require(:group).permit(:name, :introduction, :image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == Current.user.id
      redirect_to groups_path
    end
  end

  
end
