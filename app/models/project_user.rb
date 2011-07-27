class ProjectUser < ActiveRecord::Base
  set_table_name 'projects_users'
  default_scope :order => 'role'
  
  belongs_to :user
  belongs_to :project
  
  def role_text
    if role == PROJECT_ROLE_SCRUMMASTER
      "Scrum master"
    else
      "Team mate"
    end
  end
  
end