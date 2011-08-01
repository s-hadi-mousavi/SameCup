class UserStoriesController < ApplicationController
  before_filter :authenticate_user!, :_get_project, :_check_permission
  
  # GET /user_stories
  # GET /user_stories.xml
  def index
    @user_stories = UserStory.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_stories }
    end
  end

  # GET /user_stories/1
  # GET /user_stories/1.xml
  def show
    @user_story = UserStory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_story }
    end
  end

  # GET /user_stories/new
  # GET /user_stories/new.xml
  def new
    @user_story = UserStory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_story }
    end
  end

  # GET /user_stories/1/edit
  def edit
    @user_story = UserStory.find(params[:id])
  end

  # POST /user_stories
  # POST /user_stories.xml
  def create
    @user_story = UserStory.new(params[:user_story])
    @user_story.save
    @sprint = @user_story.sprint
      respond_to do |format|
          format.html { redirect_to(project_user_stories(@project)) }
          format.js
      end
  end

  # PUT /user_stories/1
  # PUT /user_stories/1.xml
  def update
    @user_story = UserStory.find(params[:id])
    @user_story.update_attributes(params[:user_story])
    @sprint = @user_story.sprint
    
    respond_to do |format|
        format.html { redirect_to(project_user_stories(@project)) }
        format.js 
    end
  end

  # DELETE /user_stories/1
  # DELETE /user_stories/1.xml
  def destroy
    @user_story = UserStory.find(params[:id])
    @sprint = @project.sprints.find(@user_story.sprint_id)
    unless @sprint.nil?
      @user_story_id = @user_story.id
      @user_story.destroy 
    end
  end
  
  # POST /{project_id}/user_stories/{story_id} new sticker to story
  def add_sticker
    @sticker = Sticker.new()
    @sprint = @project.sprints.find(params[:sprint_id])
    @story_id = "nil"
    unless params[:story_id].nil? 
      @story_id = params[:story_id]
      @story = @sprint.user_stories.find(@story_id)
      
      @sticker.user_story_id = @story_id
    end 
    @sticker.description = 'As a user I want'
    @sticker.sprint_id = @sprint.id   
    @sticker.project_id = @project.id
    @sticker.color = "#FFF046"
    @sticker.left = 0
    @sticker.top = 0
    @sticker.save
  end
  
  def update_sticker
    @sticker = Sticker.find params[:id]
    @sprint = @sticker.sprint
    if @sticker.sprint.project.member?(current_user.id)
      @sticker.update_attributes(params[:sticker])
      
      #if you set user to None than put nil
      if(params[:sticker][:user_id].blank?)
        @sticker.user_id = nil
        @sticker.state_id = nil
        @sticker.top = 10
        @sticker.left = 10
        @sticker.project_id =  @project.id
        @sticker.save
       end
        
      if @sticker.state.nil? && !@sticker.user.nil?
          @sticker.state = @project.states.first
          @sticker.save
      end
    end
  end
  
  def show_dialog
    @user_story = UserStory.find(params[:id])
    @sprint = @project.sprints.find(@user_story.sprint_id)
    unless @sprint.nil?
      respond_to do |format|
          format.js 
      end
    end
  end
  
  private 
  
  def _get_project
    @project = current_user.projects.find_by_alias(params[:project_id])
  end
  
  private 
    def _check_permission
      unless current_user.is_master_of_project?(@project)
        render :partial => "shared/nopermission", :status => 403
      end
    end
  
end
