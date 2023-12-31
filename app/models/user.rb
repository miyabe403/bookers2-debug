class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # belongs_to :books
  has_one_attached :profile_image
  has_many :books, dependent: :destroy  
  has_many :book_comments, dependent: :destroy 
  has_many :favorites, dependent: :destroy  # Userモデルにも追加
  
  # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed
  
  
  # # フォローをした、されたの関係
  # # has_many :xxxはアソシエーションが繋がっているテーブル名、class_nameは実際のモデルの名前、foreign_keyは外部キーとして何を持つかを表しています。
  # has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # # 一覧画面で使う
  # #「has_many :テーブル名, through: :中間テーブル名」 の形を使って、テーブル同士が中間テーブルを通じてつながっていることを表現します。(followerテーブルとfollowedテーブルのつながりを表す）
  # # 例えば、has_many :yyyにfollowedを入れてしまうと、followedテーブルから中間テーブルを通ってfollowerテーブルにアクセスすることができなくなってしまいます。
  # #  これを防ぐためにhas_many :yyyには架空のテーブル名を、source: :zzzは実際にデータを取得しにいくテーブル名を書きます。
  # has_many :following_users, through: :followers, source: :followed
  # has_many :follower_users, through: :followeds, source: :follower
  
  # #この結果、@user.yyyとすることでそのユーザーがフォローしている人orフォローされている人の一覧を表示することができるようになります。


  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms
  
  has_many :view_counts, dependent: :destroy
  
  has_many :group_users, dependent: :destroy

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}  # introductionカラムの追加 

  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  def follow(user)
    relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
  
  # # フォローしたときの処理
  # def follow(user_id)
  #   followers.create(followed_id: user_id)
  # end
  
  # # フォローを外すときの処理
  # def unfollow(user_id)
  #   followers.find_by(followed_id: user_id).destroy
  # end
  
  # # フォローしていればtrueを返す
  # def following?(user)
  #   following_users.include?(user)
  # end
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?", "#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
end
