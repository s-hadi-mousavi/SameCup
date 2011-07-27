class RemoveSprintAlias < ActiveRecord::Migration
  def self.up
    remove_column :sprints, :alias
  end

  def self.down
   add_column :sprints, :alias, :string
  end
end
