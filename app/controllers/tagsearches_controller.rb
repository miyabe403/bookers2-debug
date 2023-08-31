class TagsearchesController < ApplicationController
  def search
    @model = Book  #search機能とは関係なし
    @word = params[:content]
    @books = Book.where("category LIKE?","%#{@word}%")
    @book = Book.new  # 空のインスタンス変数を追加 
    render "tagsearches/_tagsearch_result"
  end
end
