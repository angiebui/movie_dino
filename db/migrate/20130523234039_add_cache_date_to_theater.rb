class AddCacheDateToTheater < ActiveRecord::Migration
  def change
    change_table :theaters do |t|
      t.datetime :cache_date
    end
  end
end
