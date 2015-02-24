class AddStarsCounterToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :stars_count, :integer, :default => 0
  end
end
