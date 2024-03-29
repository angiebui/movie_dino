class AddTrigramsModel < ActiveRecord::Migration
  def up
    create_table :trigrams do |t|
      t.string :trigram, limit: 3
      t.integer :score, limit: 2
      t.integer :owner_id
      t.integer :owner_type
      t.string :fuzzy_field
    end
    add_index :trigrams, [:owner_id, :owner_type, :fuzzy_field, :trigram, :score], name: 'index_for_match'
    add_index :trigrams, [:owner_id, :owner_type], name: 'index_by_owner'
  end
end
