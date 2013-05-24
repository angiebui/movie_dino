class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.references :outing

      t.timestamps
    end
  end
end
