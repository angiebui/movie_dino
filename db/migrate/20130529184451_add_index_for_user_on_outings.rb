class AddIndexForUserOnOutings < ActiveRecord::Migration
  def up
    add_index :outings, :user_id
  end

  def down
    remove_index :outings, :user_id
  end
end
