class ReportController < ApplicationController
before_filter :authenticate_user!, :_get_project, :_check_permission


def index
 @reports = @project.sprint_reports.order("date2") 
 
 unless @reports.blank?

   @points = []
   @points = "['#{@reports.first.date1.to_s}',#{@reports.first.total_left_points1}]"

   @dates = "0:'#{@reports.first.date1.to_s}'"
   @start_date = @reports.first.date1
   i = 1
 
   @reports.each{|r|
    #   @points << r.total_left_points2 unless r.date2.nil?
    #   i= (r.date2 - @start_date).to_i
    #   @dates = @dates+",#{i}:'#{r.date2.to_s}'"
      @points = @points + ",['#{r.date2.to_s}',#{r.total_left_points2}]"
    
     }
 
   if @reports.count > 1
     @last_report = @reports.last
     p1 = @last_report.total_left_points2
     p0 = @last_report.total_left_points1
     d1 = @last_report.date2
     d0 = @last_report.date1
   
     @deadline =  d1 + p1/( (p1 - p0).abs/(d1 - d0) );

   
     @endpoints = "['#{d1.to_s}', #{p1}],['#{@deadline.to_s}', 0]"
   end
   #end reports blank check
 end
 
end

private 
def _get_project
  @project = current_user.projects.find_by_alias(params[:id])
end

  def _check_permission
    unless current_user.is_master_of_project?(@project)
      render :partial => "shared/nopermission", :status => 403
    end
  end


end
