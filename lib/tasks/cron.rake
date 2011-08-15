desc "Project sprint start/end statistics"
task :cron => :environment do
   projects = {}
   start_sprints = Sprint.find_all_by_start_at(Date.today.to_s)
   start_sprints.each{|sprint|
      #preparing project
      #projects[sprint.project_id] = sprint.project unless projects.has_key?(sprint.project_id)
      #project = projects[sprint.project_id]

      sprint_rep = SprintReport.find_or_create_by_sprint_id(sprint.id)
      sprint_rep.project_id = sprint.project_id
      sprint_rep.date1 = sprint.start_at
      sprint_rep.total_points1 = sprint.project.stickers.sum(:points)
      #total points - sticker.points that are "Done" state
      sprint_rep.total_left_points1 = sprint_rep.total_points1-sprint.project.stickers.sum(:points, :conditions=>"state_id = #{sprint.project.states.last.id}")
      sprint_rep.total_stickers1 = sprint.project.stickers.count
      sprint_rep.save
     }

     Sprint.find_all_by_end_at(Date.today.to_s).each{|sprint|
        sprint_rep = SprintReport.find_or_create_by_sprint_id(sprint.id)
        sprint_rep.project_id = sprint.project_id
        sprint_rep.date2 = sprint.end_at
        sprint_rep.total_points2 = sprint.project.stickers.sum(:points)
        #total points - sticker.points that are "Done" state
        sprint_rep.total_left_points2 = sprint_rep.total_points2-sprint.project.stickers.sum(:points, :conditions=>"state_id = #{sprint.project.states.last.id}")
        sprint_rep.total_stickers2 = sprint.project.stickers.count
        sprint_rep.save
       }

end
