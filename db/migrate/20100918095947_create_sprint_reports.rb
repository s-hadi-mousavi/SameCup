class CreateSprintReports < ActiveRecord::Migration
  def self.up
    create_table :sprint_reports do |t|
      t.integer :project_id
      t.integer :sprint_id
      t.date :date1
      t.integer :total_points1
      t.integer :total_left_points1
      t.integer :total_stickers1
      t.date :date2
      t.integer :total_points2
      t.integer :total_left_points2
      t.integer :total_stickers2
      t.timestamps
    end
  end

  def self.down
    drop_table :sprint_reports
  end
end
