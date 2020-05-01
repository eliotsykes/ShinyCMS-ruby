class CreateEmailRecipients < ActiveRecord::Migration[6.0]
  def change
    create_table :email_recipients do |t|
      t.uuid :token, default: -> { "gen_random_uuid()" }, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.string :canonical_email, null: false

      t.timestamps
    end
    add_index :email_recipients, :canonical_email, unique: true
    add_index :email_recipients, :email, unique: true
    add_index :email_recipients, :token, unique: true
  end
end
