class CreateRetweets < ActiveRecord::Migration[6.0]
  def change
    create_table :retweets do |t|
      t.references :tweet, null: false, foreign_key: true
      t.integer :retweeter_id

      t.timestamps
      t.index [:tweet, :retweeter_id], unique: true
    end
  end
end
