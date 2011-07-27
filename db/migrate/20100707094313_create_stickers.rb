class CreateStickers < ActiveRecord::Migration
  def self.up
    create_table :stickers do |t|
      t.string :description
      t.references :user
      t.references :project
      t.references :state

      t.timestamps
    end
  end

  def self.down
    drop_table :stickers
  end
end
