require 'open_id_authentication'

class AuthorizationController < ApplicationController
  include OpenIdAuthentication
  
  GOOGLE_OPENID = 'https://www.google.com/accounts/o8/id'
   GOOGLE_KEY = 'samecup.com'
   GOOGLE_TOKEN = 'osrEdS1C6uWMZVnF5Kd2jYhE'
  
   OPENID_REQUIRED = [
     :nickname,
     :email,
     :fullname,
     'http://axschema.org/contact/email',
     'http://axschema.org/namePerson/first',
     'http://axschema.org/namePerson/last'
   ]
  
   OPENID_OPTIONAL = [
     'http://axschema.org/contact/country/home',
     'http://axschema.org/pref/language'
   ]
  
  def index
    #inteligence post login redirect
    redirect_url = root_url
      if user_signed_in?
        if current_user.projects.blank?
          redirect_url = user_projects_url
        else 
          redirect_url = user_project_url(current_user, current_user.projects.first)
        end
      end
      
      redirect_to(redirect_url)
  end
  
  
   def google
       oauth_data = {
         :consumer_key => GOOGLE_KEY,
         :scope        => [GData::Client::GMail.new].collect(&:oauth_scope).join(' '),
         :ns_alias     => 'ext2'
       }
  
       authenticate_with_open_id(GOOGLE_OPENID, :required => OPENID_REQUIRED, :optional => OPENID_OPTIONAL, :oauth => oauth_data) do |result, identity_url, registration|

         email = registration[:email] || registration['http://axschema.org/contact/email'].try(:first)

         first_name = registration['http://axschema.org/namePerson/first'].try(:first) || ''
         last_name = registration['http://axschema.org/namePerson/last'].try(:first) || ''
         full_name = [first_name, last_name].join(' ').strip
         full_name = registration[:fullname] if full_name.empty?

         # login_from_full_name = full_name.downcase.gsub(/[.,]/, '').gsub(/\s+/, '_')
         #   login_from_full_name = nil if login_from_full_name.empty?
         # 
         #   login = registration[:nickname] || login_from_full_name
         #   
                
         u = User.find_by_email(email)
         if u.nil?
           flash[:alert] = "Email `#{email}` not found in the system. Do you want <a href='#{new_user_registration_url(:email=>email,:name=>full_name)}'>create account</a> with this email?"
           return redirect_to(new_user_session_url)
         else
           sign_in(u)
           return redirect_to(root_url)
         end  
       end
       
   end

end
