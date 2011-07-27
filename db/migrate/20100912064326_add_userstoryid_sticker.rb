class AddUserstoryidSticker < ActiveRecord::Migration
  def self.up
    add_column :stickers, :user_story_id, :integer
  end

  def self.down
    remove_column :stickers, :user_story_id
  end
end
