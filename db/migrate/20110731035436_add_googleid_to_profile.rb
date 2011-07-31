class AddGoogleidToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :google_id, :string

  end

  def self.down
    remove_column :profiles, :google_id
  end
end
