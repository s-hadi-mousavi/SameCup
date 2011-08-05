class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model
    @user = UserIntegration.find_for_facebook_oauth(env["omniauth.auth"], current_user)
    if @user.persisted?
      return  redirect_to(edit_user_registration_path(current_user)) if user_signed_in?
      
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  
  def twitter  
    # You need to implement the method below in your model
    @user = UserIntegration.find_for_twitter_oauth(env["omniauth.auth"], current_user)

    if @user.persisted?
      return  redirect_to(edit_user_registration_path(current_user)) if user_signed_in?
      
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.twitter_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  def google  
    # You need to implement the method below in your model
    @user = UserIntegration.find_for_google_oauth(env["omniauth.auth"], current_user)

    if @user.persisted?
      return  redirect_to(edit_user_registration_path(current_user)) if user_signed_in?
      
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  
end