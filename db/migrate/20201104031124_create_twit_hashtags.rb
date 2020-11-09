class CreateTwitHashtags < ActiveRecord::Migration[6.0]
  def change
    create_table :twit_hashtags do |t|
      t.references :twit, null: false, foreign_key: true
      t.references :hashtag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
