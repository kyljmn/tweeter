class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.integer :postable_id
      t.string :postable_type
      t.integer :user_id
      t.timestamps
    end
  end
end
