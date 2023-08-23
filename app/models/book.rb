class Book < ApplicationRecord
  # Book モデルには、ActiveStorage を使って画像を持たせます。
  has_one_attached :profile_image
   
  # has_many :user
  belongs_to :user
  has_many :favorites, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
