class RenameContactDateToResultDate < ActiveRecord::Migration
  def up
    rename_column :outings, :email_contact_date, :result_date
  end

  def down
    rename_column :outings, :result_date, :email_contact_date
  end
end
