class CreateSelectedJoinTable < ActiveRecord::Migration
  def up
    create_table :selected do |t|
      t.references :attendees
      t.references :selections
    end
  end

  def down
    drop_table :selected
  end
end
