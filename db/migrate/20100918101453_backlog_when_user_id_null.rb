class BacklogWhenUserIdNull < ActiveRecord::Migration
  def self.up
    Sticker.all.each{ |sticker|
      sticker.update_attributes(:project_id => sticker.sprint.project_id) if sticker.project_id.nil?
    }
  end

  def self.down
  end
end
