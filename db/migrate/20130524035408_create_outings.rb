class CreateOutings < ActiveRecord::Migration
  def change
    create_table :outings do |t|
      t.references :user
      t.integer :final_selection_id
      
      t.timestamps
    end
  end
end


