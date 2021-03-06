class AddCountersToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ideas_count, :integer, :default => 0
    add_column :users, :comments_count, :integer, :default => 0
    add_column :users, :visits_count, :integer, :default => 0
    add_column :users, :followees_count, :integer, :default => 0
    add_column :users, :followers_count, :integer, :default => 0
    add_column :users, :liked_ideas_count, :integer, :default => 0

    add_index  :users, :ideas_count
    add_index  :users, :followers_count
  end
end
