class ProjectObserver < ActiveRecord::Observer

  def after_create(project)
    ["Done", "In progress", "Inbox"].each do |state|
      project.states.build(:name => state)
    end

    project.sprints.build(:name => 'New sprint',:description=>'', :start_at => Time.now, :end_at => Time.now + 1.week)
    project.save!
  end

end

