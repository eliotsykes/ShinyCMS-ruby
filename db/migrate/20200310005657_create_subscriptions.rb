class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.integer :subscriber_id, null: false
      t.string :subscriber_type, null: false, default: 'EmailRecipient'
      t.integer :mailing_list_id, null: false

      t.timestamps
    end
  end
end
