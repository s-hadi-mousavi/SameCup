class SprintsController < ApplicationController
  before_filter  :authenticate_user!
  before_filter :_get_project
  
  # GET /sprints
  # GET /sprints.xml
  def index
    @project = current_user.projects.find_by_alias(params[:project_id])
    @sprints = @project.sprints.all if @project

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sprints }
    end
  end

  # GET /sprints/1
  # GET /sprints/1.xml
  def show
    @project = current_user.projects.find_by_alias(params[:project_id])
    @sprint = @project.sprints.find(params[:id]) if @project
    render :template => '/projects/show'
  end

  # GET /sprints/new
  # GET /sprints/new.xml
  def new
    @project = current_user.projects.find_by_alias(params[:project_id])
    
    unless @project or @project.owner == current_user
      redirect_to '/500.html'
    else
      
    
      @sprint = Sprint.new(:project_id => @project.id)
      _get_next_and_previous @sprint
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @sprint }
      end
    end
  end

  # GET /sprints/1/edit
  def edit
    @sprint = Sprint.find(params[:id])
    _get_next_and_previous @sprint
  end

  # POST /sprints
  # POST /sprints.xml
  def create
    @sprint = Sprint.new(params[:sprint])
    @project = @sprint.project
    
    
    _get_next_and_previous @sprint    
    
    respond_to do |format|
      if @sprint.project.owner == current_user and @sprint.save
        format.html { redirect_to(project_sprints_url(@sprint.project), :notice => 'Sprint was successfully created.') }
        format.xml  { render :xml => @sprint, :status => :created, :location => @sprint }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sprint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sprints/1
  # PUT /sprints/1.xml
  def update
    @sprint = Sprint.find(params[:id])
    _get_next_and_previous @sprint

    respond_to do |format|
      if @sprint.project.owner == current_user and @sprint.update_attributes(params[:sprint])
        format.html { redirect_to(project_sprint_path(@sprint.project, @sprint), :notice => 'Sprint was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sprint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sprints/1
  # DELETE /sprints/1.xml
  def destroy
    @sprint = Sprint.find(params[:id])
    @project = @sprint.project
    if(@project.sprints.count == 1)
      yeld[:notice] = "You cann't have project without sprints"
    end
    @sprint.destroy if @sprint.project.owner == current_user and @project.sprints.count > 1
        
    respond_to do |format|
      format.html { redirect_to(project_sprints_url(@project)) }
      format.xml  { head :ok }
    end
  end
private 
  def _get_next_and_previous(sprint)
    @project = sprint.project
    unless sprint.id.nil? 
      @previous_sprint = @project.sprints.find(:first, :conditions => "end_at <= '#{sprint.start_at}'", :order => "end_at DESC")
      @next_sprint = @project.sprints.find(:first, :conditions => "start_at >= '#{sprint.end_at}'", :order => "start_at")
    else
      
      @previous_sprint = @project.sprints.find(:first, :order => "end_at DESC")
      sprint.start_at = @previous_sprint.end_at + 1.day
      sprint.end_at = sprint.start_at + 1.week
      @next_sprint = nil
    end
  end
  
  private 
  def _get_project
    @project = current_user.projects.find_by_alias(params[:project_id])
  end
end
