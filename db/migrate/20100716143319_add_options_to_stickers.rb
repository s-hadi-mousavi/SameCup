class AddOptionsToStickers < ActiveRecord::Migration
  def self.up
    add_column :stickers, :options, :string
  end

  def self.down
    remove_column :stickers, :options
  end
end
