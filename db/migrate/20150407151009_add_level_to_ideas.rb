class AddLevelToIdeas < ActiveRecord::Migration
  def up
    add_column :ideas, :level, :integer, :default => 0
    
    Idea.update_all(level: 0)
  end
  
  def down
    remove_column :ideas, :level
  end
end
