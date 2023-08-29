class Book < ApplicationRecord
  # Book モデルには、ActiveStorage を使って画像を持たせます。
  has_one_attached :profile_image
   
  # has_many :user
  belongs_to :user
  has_many :book_comments, dependent: :destroy 
  has_many :favorites, dependent: :destroy  # Bookモデルにも追加
  
  has_many :view_counts, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日1日で作成した 全Bookを取得  
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 昨日1日で作成した 全Bookを取得
  scope :created_2day_ago, -> { where(created_at: 2.day.ago.all_day) } # 2日前  
  scope :created_3day_ago, -> { where(created_at: 3.day.ago.all_day) } # 3日前
  scope :created_4day_ago, -> { where(created_at: 4.day.ago.all_day) } # 4日前
  scope :created_5day_ago, -> { where(created_at: 5.day.ago.all_day) } # 5日前
  scope :created_6day_ago, -> { where(created_at: 6.day.ago.all_day) } # 6日前
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } # 6日前の0:00から今日の23:59までに作成した 全Bookを取得
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } # 2週間前の0:00から1週間前の23:59までに作成した 全Bookを取得
  
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
