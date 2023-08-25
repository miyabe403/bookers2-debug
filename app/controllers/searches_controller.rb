class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search # 検索フォームからの情報を取得 検索モデル→params[:range] 検索方法→params[:search] 検索ワード→params[:word]
    @range = params[:range]
    
    if @range == "User" # if文を使い、検索モデルUserorBookで条件分岐 looksメソッドを使い、検索内容を取得し、変数に代入
      @users = User.looks(params[:search], params[:word]) # 検索方法params[:search]と、検索ワードparams[:word]を参照してデータを検索し、インスタンス変数@usersにUserモデル内での検索結果を代入
    else
      @books = Book.looks(params[:search], params[:word]) # 検索方法params[:search]と、検索ワードparams[:word]を参照してデータを検索し、インスタンス変数@booksにBookモデル内での検索結果を代入
    end
  end
end
