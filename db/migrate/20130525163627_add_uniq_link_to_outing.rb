class AddUniqLinkToOuting < ActiveRecord::Migration
  def change
    add_column :outings, :link, :string
  end
end
