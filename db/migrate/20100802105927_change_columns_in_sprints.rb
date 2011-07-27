class ChangeColumnsInSprints < ActiveRecord::Migration
  def self.up
    change_column :sprints, :start_at, :date
    change_column :sprints, :end_at, :date
  end

  def self.down
    change_column :sprints, :start_at, :datetime
    change_column :sprints, :end_at, :datetime
  end
end
