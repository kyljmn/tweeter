class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :notifiable_id
      t.string :notifiable_type
      t.integer :user_id
      t.boolean :is_read, :default => false

      t.timestamps
    end
  end
end
