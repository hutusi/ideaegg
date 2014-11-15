class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :title
      t.text :description
      t.boolean :public, default: true

      t.references :users

      t.timestamps
    end
    add_index :ideas, [:user_id]
  end
end
