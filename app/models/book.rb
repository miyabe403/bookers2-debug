class Book < ApplicationRecord
  # Book モデルには、ActiveStorage を使って画像を持たせます。
  has_one_attached :profile_image 
   
  # has_many :user
  belongs_to :user 
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
end
