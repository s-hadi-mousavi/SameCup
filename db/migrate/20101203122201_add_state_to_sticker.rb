class AddStateToSticker < ActiveRecord::Migration
  def self.up
    add_column :stickers, :state, :int, :default => 1 #inbox
  end

  def self.down
    remove_column :stickers, :state
  end
end
