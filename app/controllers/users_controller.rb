class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create] 
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

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
      @books = @user.books
      @book = Book.new

      # 検索の処理
      if params[:created_at].present?
        @search_book = @user.books.where(created_at: params[:created_at].to_date.all_day)
      else
        @search_book = Book.none
      end
    # 今日の投稿
    @today_book = @books.created_today
    # 前日の投稿
    @yesterday_book = @books.created_yesterday
    # 今週の投稿
    @this_week_book = @books.created_this_week
    # 先週の投稿
    @last_week_book = @books.created_last_week
    # --- ここまで ---

    @books_6days_ago = @books.created_6days_ago
    @books_5days_ago = @books.created_5days_ago
    @books_4days_ago = @books.created_4days_ago
    @books_3days_ago = @books.created_3days_ago
    @books_2days_ago = @books.created_2days_ago
    @books_yesterday = @books.created_yesterday # 上と重複しますが、一覧用に用意
    @books_today = @books.created_today
    
    
    
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

  def search
    @user = User.find(params[:user_id])
    @books = @user.books
    @book = Book.new

    # --- showアクションと同じ変数をここでも用意する ---
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
    
    # 7日分などの変数も使っているなら、それもここにコピーします
    @books_6days_ago = @books.created_6days_ago
    @books_5days_ago = @books.created_5days_ago
    @books_4days_ago = @books.created_4days_ago
    @books_3days_ago = @books.created_3days_ago
    @books_2days_ago = @books.created_2days_ago
    @books_yesterday = @books.created_yesterday
    @books_today = @books.created_today
    # ---------------------------------------------

    # 検索の処理
    if params[:created_at].blank?
      @search_book = Book.none
    else
      @search_book = @books.where(created_at: params[:created_at].to_date.all_day)
    end
    

    render "show"
  end

  

  private
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == Current.user.id
      redirect_to user_path(Current.user.id)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
 
  def user_params
    
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :profile_image, :introduction)
  end


end
