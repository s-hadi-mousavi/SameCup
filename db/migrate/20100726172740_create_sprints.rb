class CreateSprints < ActiveRecord::Migration
  def self.up
    create_table :sprints do |t|
      t.text :description
      t.references :project
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
    
    add_index :sprints, :project_id
  end

  def self.down
    drop_table :sprints
  end
end
