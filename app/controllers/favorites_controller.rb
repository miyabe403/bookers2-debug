class FavoritesController < ApplicationController
  
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    render 'create'
    #redirect_to book_path(book) #いいね保存のリダイレクト先を削除 createアクション実行後は、create.js.erbファイルを、探すようになります。
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    render 'destroy'
    #redirect_to book_path(book) #いいね削除のリダイレクト先を削除 destroyアクション実行後はdestroy.js.erbファイルを探すようになります。
  end
end
