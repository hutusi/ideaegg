class AddMissingColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wechat_openid, :string
    add_column :users, :phone_number, :string
    add_column :users, :level, :integer
    add_column :users, :money, :integer
    add_column :users, :avatar, :string
  end
end
