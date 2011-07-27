class ProjectsController < ApplicationController
  include ActiveModel::Validations
  
  before_filter  :authenticate_user!
  
  # GET /projects
  # GET /projects.xml
  def index
    @projects = current_user.projects

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = current_user.projects.find_by_alias(params[:id])
    
    if params[:sprint_id]
      @sprint = @project.sprints.find(params[:sprint_id])
    else
      @sprint = @project.current_sprint
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

   # GET /projects/1/dashboard
   # GET /projects/1.xml/dashboard
   def dashboard
     @project = current_user.projects.find_by_alias(params[:id])
     @sprint = @project.current_sprint
     
     respond_to do |format|
       format.html # show.html.erb
       format.xml  { render :xml => @project }
     end
   end

  # GET /projects/1/edit
  def edit
    @project = current_user.projects.find_by_alias(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = current_user.projects.create(params[:project])
    @project.owner = current_user
    default = ["Done", "In progress", "Inbox"]
    3.times do
      @project.states.build(:name => default.pop)
    end
    @project.sprints.build(:name => 'New sprint',:description=>'', :start_at => Time.now, :end_at => Time.now + 1.week)
    respond_to do |format|
      if @project.save
        owner = @project.members.find_by_user_id(current_user.id)
        owner.update_attributes(:role => PROJECT_ROLE_SCRUMMASTER)
        format.html { redirect_to(@project) }#, :notice => 'Project was successfully created.'
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = current_user.projects.find_by_alias( params[:id], :readonly => false)

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(@project) } #, :notice => 'Project was successfully updated.'
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = current_user.projects.find_by_alias(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
  
  def refresh
    @sprint = Sprint.find(params[:sprint_id])
    @project = @sprint.project
    render :partial => "dashboard", :layout => false, :locals => {:project => @project}
  end
  

end
