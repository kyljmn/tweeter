class AddReplyToIdToTwits < ActiveRecord::Migration[6.0]
  def change
    add_column :twits, :reply_to_id, :integer
  end
end
