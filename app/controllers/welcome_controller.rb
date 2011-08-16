class WelcomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :rss, :static]

  def index
    @projects_count = Project.count
  end
 
  def static
    allowed_names = ['termsofuse', 'privacypolicy', 'prices', 'tour']
    partial_name = request.path.downcase.gsub(/\//,'')
    if allowed_names.include?( partial_name )
      render partial_name
    else
      redirect_to :root
    end
  end
end
