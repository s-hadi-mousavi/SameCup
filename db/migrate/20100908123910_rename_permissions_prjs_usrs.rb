class RenamePermissionsPrjsUsrs < ActiveRecord::Migration
  def self.up
    rename_column :projects_users, :permission, :role
    ProjectUser.update_all("role = 2")
    Project.all.each{|p| 
      pu = p.members.find_by_user_id(p.owner.id)
      pu.update_attributes(:role => 1)
    }
  end

  def self.down
    rename_column :projects_users, :role, :permission
  end
end
