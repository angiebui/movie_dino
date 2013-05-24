class CreateSelections < ActiveRecord::Migration
  def change
    create_table :selections do |t|
      t.references :movie
      t.references :showtime
      t.references :selectable, :polymorphic => true
      t.timestamps
    end
  end
end
