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
end
