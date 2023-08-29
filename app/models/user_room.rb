class UserRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  # validates :message, length: { in: 1..140 } # 1~140文字内でないといけないというバリデーション
end
