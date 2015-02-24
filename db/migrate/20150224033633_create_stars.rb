class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.references :starrable, :polymorphic => true
      t.references :user

      t.timestamps
    end

    add_index :stars, [:starrable_id, :starrable_type]
    add_index :stars, [:user_id]
  end
end
