class Favorite < ApplicationRecord
  
  belongs_to :user  # Favoriteモデルのカラム（user_idとbook_id）を、UserモデルのidやBookモデルのidに関連付けを設定
  belongs_to :book  # Favoriteモデルのカラム（user_idとbook_id）を、UserモデルのidやBookモデルのidに関連付けを設定
  
end
