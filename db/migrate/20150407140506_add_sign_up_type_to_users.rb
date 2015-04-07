class AddSignUpTypeToUsers < ActiveRecord::Migration
  def up
    add_column :users, :sign_up_type, :string, :default => "web"
    change_column :users, :level, :integer, :default => 0
    change_column :users, :money, :integer, :default => 0
    
    User.update_all(sign_up_type: "web")
    User.where(level: nil).update_all(level: 0)
    User.where(money: nil).update_all(money: 0)
  end
  
  def down
    remove_column :users, :sign_up_type
    change_column :users, :level, :integer, :default => nil
    change_column :users, :money, :integer, :default => nil
  end
end
