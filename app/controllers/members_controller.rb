class MembersController < ApplicationController
before_filter :authenticate_user!,:_get_project, :_check_permission

def index
end

#DELETE /projects/1/members/1/remove
def remove
  @user = User.find(params[:id])
  
  if @project.owner == current_user && @user != current_user
    @project.users.delete(@user)
  end
  respond_to do |format|
    format.html { redirect_to(project_members_path(@project)) }
    format.xml  { head :ok }
  end
end

#GET /project/1/members/1/changerole
def changerole
  @user = User.find_by_id(params[:id])
  @success = false
  role = params[:role].to_i
  
  if !@project.nil? && !@user.nil? && current_user == @project.owner && (role == PROJECT_ROLE_SCRUMMASTER || role == PROJECT_ROLE_TEAMMATE)
    @member = @project.members.find_by_user_id(@user.id)
    @member.update_attributes(:role => role)
    @success = true
  end
end

#POST /projects/1/members/invite
def invite
  @errors = []
  if @project.nil?
    @errors << "Wrong project"
  else
    email = params[:email]
    if email.match( Devise::email_regexp )
      user = User.find_by_email(email)
       
      # if it's new user in the system
      if user.nil?
        user = User.invite!( :email => email, :name => email)
        @project.users << user
        member = @project.members.find_by_user_id(user.id)
        member.update_attributes(:role => PROJECT_ROLE_TEAMMATE)
      else
        # if user exists, we check if he is already a member
        if @project.member? user.id
          @errors << "#{email} is already a member"
        else
          # add user to the project and  send information emial
          @project.users << user
          member = @project.members.find_by_user_id(user.id)
          member.update_attributes(:role => PROJECT_ROLE_TEAMMATE)
          begin
            Notifier.deliver_user_invitation(user, @project)
          rescue
            puts "ERROR: #{$!}"
          end
          
        end
      end
    else
      @errors << "Invalid email: #{email}"
    end

  end
  respond_to do |format|
    format.html { redirect_to(@project) }
    format.js {}
  end
  
end

private 

  def _get_project
    @project = current_user.projects.find_by_alias( params[:project_id] )
  end

  def _check_permission
    unless current_user.is_master_of_project?(@project)
      render :partial => "shared/nopermission", :status => 403
    end
  end

end
