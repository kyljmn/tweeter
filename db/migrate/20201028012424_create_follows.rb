class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows do |t|
      t.references :follower, null: false, foreign_key: true
      t.references :following, null: false, foreign_key: true

      t.timestamps
      t.index :follows, [:follower, :following], unique: true
    end
  end
end
