class StickersController < ApplicationController
  before_filter :authenticate_user!, :_get_project, :_get_sprint
  protect_from_forgery :except => [:create, :update]
  layout false

  def show
  end

  def new
  end

  def edit
    @sticker = @project.stickers.find(params[:id])
  end

  def create
      
      @sprint = @project.sprints.find(params[:sprint_id]) 
      @sticker_id = params[:sticker_id]
      @state_id = params[:state_id]
      @user_id = params[:user_id]
      
      #if user is not defined than it's backlog
      return render :nothing=>true if !@user_id.nil? && !@project.member?(@user_id)
      
      @sticker = Sticker.create(
        :project_id => @project.id, 
        :sprint_id => @sprint.id, 
        :options=>{:color =>'#FFF046'},
        :description => 'As a user I want',
        :user_id => @user_id, 
        :state_id => @state_id
        ) 
  end

  def update

    @sticker = @project.stickers.find params[:id]
    if @project.member?(current_user.id) && params.has_key?(:sticker)
      #always update sprint so when moved from back log it still change sprint_id
      params[:sticker][:sprint_id] = @sprint.id
      @sticker.update_attributes(params[:sticker])

      if params[:state_id] or params[:noredraw]
        render :nothing => true
      end
    elsif !params.has_key?(:sticker)
      #move to backlog
      @sticker.update_attributes(:user_id=>nil, :state_id=>nil)
    end
  end

  def destroy
    @sticker = @project.stickers.find params[:id]
    if @sticker.sprint.project.member?(current_user.id) #do we realy need it?
      @sticker.destroy
      @id = params[:id]
    end
  end
  
  def sort
    @sticker = @project.stickers.find params[:id]
    
    if @project.member?(current_user.id)    
      #if user is not defined than it's backlog
      params[:sticker][:user_id] = nil if params[:sticker].has_key?(:user_id) && params[:sticker][:user_id].to_i == 0
      params[:sticker][:sprint_id] = params[:sprint_id]
      @sticker.update_attributes(params[:sticker])
    end
    render :nothing => true
  end
  
  def setstate
    @sticker = @project.stickers.find(params[:id])
    state = params[:state].to_i
    if([TASK_STATE_OPEN,TASK_STATE_DONE].index(state))
      @sticker.update_attribute(:state, state)
      respond_to do |format|
        format.js
      end
    else
      render :nothing =>true
    end
  end
  
  private 
  def _get_project
    @project = current_user.projects.find_by_alias(params[:project_id])
  end
  
  def _get_sprint
    @sprint = @project.sprints.find_by_id(params[:sprint_id]) 
  end
end
