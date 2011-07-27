class RemoveProjectIdFromUserstories < ActiveRecord::Migration
  def self.up
    remove_column :user_stories, :project_id
  end

  def self.down
    add_column :user_stories, :project_id, :integer
  end
end
