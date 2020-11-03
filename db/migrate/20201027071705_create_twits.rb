class CreateTwits < ActiveRecord::Migration[6.0]
  def change
    create_table :twits do |t|
      t.string :body
      t.references :user, null: false, foreign_key: true
      t.integer :retwit_id
      t.integer :owner_id

      t.timestamps
    end
  end
end
