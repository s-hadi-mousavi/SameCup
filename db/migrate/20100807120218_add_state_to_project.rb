class AddStateToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :state, :integer, :default => 1 #1 = Free project
  end

  def self.down
    remove_column :projects, :state
  end
end
