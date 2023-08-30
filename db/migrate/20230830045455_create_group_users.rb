class CreateGroupUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_users do |t|  # group_usersに外部キーとしてuser_idとgroup_idを登録
      t.references :user, foreign_key: true  # reference型では外部キー制約をつけるときに、foreign_key: trueが使える
      t.references :group, foreign_key: true
      
      t.timestamps
    end
  end
end
