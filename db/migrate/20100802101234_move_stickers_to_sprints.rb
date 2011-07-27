class MoveStickersToSprints < ActiveRecord::Migration
  def self.up
    begin
          rename_column :stickers, :project_id, :sprint_id
        rescue Exception => e
          puts e.message
        end
        
        
        Project.all.each { |project| project.sprints.create(:name => 'Sprint', :description => 'Generic sprint', :start_at => 1.week.ago, :end_at => Time.now + 3.weeks) }
        
        Sticker.all.each{ |sticker| id = sticker.sprint_id; sprint = Project.find(id).sprints.first; sticker.update_attributes(:sprint_id =>sprint.id); }       
          
  end

  def self.down
    rename_column :stickers, :sprint_id, :project_id
    Sprint.destroy_all
  end
end
