class ChangeStickerPointsDefault < ActiveRecord::Migration
  def self.up
    change_column :stickers, :points, :integer, :default => 5
    Sticker.update_all(:points => 5)
  end

  def self.down
  end
end
