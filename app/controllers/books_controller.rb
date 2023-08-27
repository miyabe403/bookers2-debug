class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new #空のインスタンスを用意 formの中身を空にする用 
    @user = User.new  # 空のインスタンスを用意 部分テンプレートに渡す引数用
    @book_comment = BookComment.new
  end

  def index
    @book = Book.new  # 空のインスタンス変数を追加 
    @books = Book.all 
    
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy # delete のスペルミスを destroy に修正
    @book = Book.find(params[:id])
    @book.destroy  # destoy のスペルミスを destroy に修正
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)  # ストロングパラメータにbodyを追加 
  end
end
