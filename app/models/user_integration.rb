class UserIntegration
  #-----------------------------Integration
  
   def self.find_for_facebook_oauth(access_token, user=nil)
     data = access_token['extra']['user_hash']
     user_info = access_token['user_info']
     access_token['extra'].delete('access_token')
     uid = access_token['uid']

     #If user logged and want to add Twitter auth 
     if !user.nil?
       data = access_token['extra']['user_hash']
       user.profile.params = access_token
       # user.profile.city = user_info["location"]
       user.profile.facebook_id = data['id']
       user.profile.save(:validate => false)
       user

     #Check if we have email registered wit this
     elsif user = User.find_by_email(data["email"])
       user.profile.update_attribute(:facebook_id, uid)
       user

     #Check profile with twitter_id
     elsif profile = Profile.find_by_facebook_id(uid)
       profile.user

     # Create an user with a stub password.
     else  
      user = User.new(:email => data["email"], :password => Devise.friendly_token[0,20])
      user.name = user_info['nickname'].gsub(".","-") if User.count(:conditions=>{:name => user_info['nickname']}) == 0
      user.save(:validate => false)
      user.confirm!

      unless user.nil?
        user.profile.params = access_token
        user.profile.facebook_id = data['id']
        user.profile.save(:validate => false)
      end
      user
     end
   
  end

   def self.find_for_twitter_oauth(access_token, user=nil)
    access_token['extra'].delete('access_token')
    uid = access_token['uid']
    
    #If user logged and want to add Twitter auth 
    if !user.nil?
      data = access_token['extra']['user_hash']
      user.profile.params = access_token
      # user.profile.city = user_info["location"]
      user.profile.twitter_id = data['id']
      user.profile.save(:validate => false)
      user
      
    #Check profile with twitter_id
    elsif profile = Profile.find_by_twitter_id(uid)
      profile.user
      
    # Create an user with a stub password.
    else  
     user_info = access_token['user_info']
     data = access_token['extra']['user_hash']

     user = User.new(:email => "#{uid}@twitter.com", :password => Devise.friendly_token[0,20])
     user.name = user_info['nickname'].gsub(".","-") if User.count(:conditions=>{:name => user_info['nickname']}) == 0
     user.save(:validate => false)
     user.confirm!

     unless user.nil?
       #user_info["image"]=>"http://a3.twimg.com/profile_images/102128608/IMG_4008_normal.jpg"
       #name = user_info['name'].split(" ")
       # user.profile.download_remote_image(user_info["image"])      
       # user.profile.first_name = name[0] if name.size > 0
       # user.profile.last_name = name[1] if name.size > 1
       user.profile.params = access_token
       # user.profile.city = user_info["location"]
       user.profile.twitter_id = data['id']
       user.profile.save(:validate => false)
     end
     user
    end
    
   end
   def self.find_for_google_oauth(access_token, user=nil)
    email = uid = access_token['user_info']['email']
    
    #If user logged and want to add Twitter auth 
    if !user.nil?
      data = access_token['extra']['user_hash']
      user.profile.params = access_token
      user.profile.google_id = uid
      user.profile.save(:validate => false)
      user

    #Check user with email
    elsif user = User.find_by_email(email)
      user.profile.params = access_token
      user.profile.google_id = uid
      user.profile.save(:validate => false)
      user
      
    #Check profile with google_id
    elsif profile = Profile.find_by_google_id(uid)
      profile.user
      
    # Create an user with a stub password.
    else  
     user = User.new(:email => email, :password => Devise.friendly_token[0,20])
     user.name = access_token["user_info"]["name"].gsub(".","-")
     user.save(:validate => false)
     user.confirm!

     unless user.nil?
       user.profile.params = access_token
       user.profile.google_id = uid
       user.profile.save(:validate => false)
     end
     user
    end
    
   end
end