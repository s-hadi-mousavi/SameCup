class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  #custom signin redirect
  # def after_sign_in_path_for(resource)
  #    if resource.is_a?(User)
  #      auth_url
  #    else
  #      super(resource)
  #    end
  #  end
  

end
