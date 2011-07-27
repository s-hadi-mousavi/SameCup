class AddProjectToSticker < ActiveRecord::Migration
  def self.up
    add_column :stickers, :project_id, :integer
  end

  def self.down
    remove_column :stickers, :project_id
  end
end
