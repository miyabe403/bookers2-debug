class Book < ApplicationRecord
  # Book モデルには、ActiveStorage を使って画像を持たせます。
  has_one_attached :profile_image
   
  # has_many :user
  belongs_to :user
  has_many :book_comments, dependent: :destroy 
  has_many :favorites, dependent: :destroy  # Bookモデルにも追加
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def favorited_by?(user) # favorited_by?メソッドを作成 引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べます。
    favorites.exists?(user_id: user.id)
  end
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"  # 完全一致 送られてきたsearchによって条件分岐
      @book = Book.where("title LIKE?","#{word}") # whereメソッドを使いデータベースから該当データを取得し、変数に代入
    elsif search == "forward_match"  # 前方一致
      @book = Book.where("title LIKE?","#{word}%") # 完全一致以外の検索方法は、#{word}の前後(もしくは両方に)、%を追記することで定義
    elsif search == "backward_match"  # 後方一致
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"  # 部分一致
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end 
end
