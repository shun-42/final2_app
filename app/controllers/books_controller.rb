class BooksController < ApplicationController

  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = Current.user.id

   if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
   else
     @books= Book.all
     @user= Current.user
     render :index,  status: :unprocessable_entity
   end
  end


  
  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    
    book = Book.find(params[:id])  
    book.destroy                
    redirect_to books_path
  end

  
  
  def index
    @books = Book.all
    @user = Current.user
    @book = Book.new

  end

  def show
    @book = Book.find(params[:id])
    @post_comment = PostComment.new
  end


  private

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user_id == Current.user.id
      redirect_to books_path
    end
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end


end