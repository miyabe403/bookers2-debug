class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User" # class_nameでクラス名（モデル名）を指定可能 これにより、正しくusersテーブルを参照
  belongs_to :followed, class_name: "User" # 関連名と参照先のクラス名を異なるものに置き換えることができるオプション。
end
