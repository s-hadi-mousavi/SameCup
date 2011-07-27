class ProjectUrlAlias < ActiveRecord::Migration
  def self.up
    add_column :projects, :alias, :string
    add_index :projects, :alias
    Project.all.each do |prj|
      prj.alias = prj.id.to_s
      prj.save
    end
  end

  def self.down
    remove_index :projects, :alias
    remove_column :projects, :alias
  end
end
