class AddCountersToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :comments_count, :integer, :default => 0
    add_column :ideas, :cached_votes_up, :integer, :default => 0

    add_index  :ideas, :cached_votes_up
  end
end
