class ProfileController < ApplicationController
  before_filter  :authenticate_user!
  
  def remove_twitter
    current_user.profile.update_attribute(:twitter_id, nil)
    redirect_to(edit_user_registration_path(current_user))
  end
  def remove_facebook
    current_user.profile.update_attribute(:facebook_id, nil)
    redirect_to(edit_user_registration_path(current_user))
  end
  def remove_google
    current_user.profile.update_attribute(:google_id, nil)
    redirect_to(edit_user_registration_path(current_user))
  end
  

end
