class AddCanonicalEmailToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :canonical_email, :string
    add_index :users, :canonical_email, unique: true
  end
end
