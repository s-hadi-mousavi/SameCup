class AddAliasToSprints < ActiveRecord::Migration
  def self.up
    add_column :sprints, :alias, :string
  end

  def self.down
    remove_column :sprints, :alias
  end
end
