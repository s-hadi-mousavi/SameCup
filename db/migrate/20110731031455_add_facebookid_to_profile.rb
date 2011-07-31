class AddFacebookidToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :facebook_id, :string
  end

  def self.down
    remove_column :profiles, :facebook_id
  end
end
