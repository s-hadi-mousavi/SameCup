class RemovePointsUserstory < ActiveRecord::Migration
  def self.up
    remove_column :user_stories, :points
    add_column :stickers, :points, :integer
  end

  def self.down
    remove_column :stickers, :points
    add_column :user_stories, :points, :integer
  end
end
