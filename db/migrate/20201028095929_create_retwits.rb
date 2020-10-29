class CreateRetwits < ActiveRecord::Migration[6.0]
  def change
    create_table :retwits do |t|
      t.integer :twit_id
      t.integer :retwiter_id

      t.timestamps
      t.index [:twit_id, :retwiter_id], unique: true
    end
  end
end
