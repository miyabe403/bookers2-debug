class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]  # editアクションを追加

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end # endを追加 

  def edit
    @user = User.find(params[:id])  # インスタンス変数を追加
  end

  def update
    if @user.update(user_params)  
      redirect_to user_path(@user), notice: "You have updated user successfully."  # パスのusers_path(@user)の末尾のsを削除 
    else
      render "edit" # render の遷移先をeditに指定 
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :title, :introduction, :profile_image)  # title を追加 
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
