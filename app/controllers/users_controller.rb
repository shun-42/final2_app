class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create] 
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      flash[:notice] = "Welcome! You have signed up successfully."
      redirect_to after_authentication_url
    else
     render :new, status: :unprocessable_entity
    end
  end

  def index    
   @users = User.all
   @user = Current.user
   @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = @user.books
  end

  def edit
    @user = User.find(params[:id])
    @user = User.find(params[:id])
    if @user != Current.user
       redirect_to books_path
    end

  end

  def update
    @user = User.find(params[:id])
      if  @user.update(user_params)
        flash[:notice] = "You have updated user successfully."
        redirect_to user_path(@user.id)
      else
        render :edit, status: :unprocessable_entity
      end  
  end

  

  private
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == Current.user.id
      redirect_to user_path(Current.user.id)
    end
  end
 
  def user_params
    
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :profile_image, :introduction)
  end


end
