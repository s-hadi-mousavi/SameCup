class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, :lockable, :omniauthable

  has_many :project_users
  has_many :projects, :through => :project_users
  has_many :stickers
  has_one :profile
        
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :name
  
  validates :name, :presence => true
  
  def gavatar_url
    begin
      "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email.strip.downcase)}"      
    rescue Exception => e
      "/images/noavatar.jpg"
    end
  end
  
  def newpass length
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(length) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end
  def is_master_of_project? project
    member = project.members.find_by_user_id(id)
    member.role == PROJECT_ROLE_SCRUMMASTER
  end  
  
  #-----------------------------Integration
  
   def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
     data = access_token['extra']['user_hash']
     user_info = access_token['user_info']
    if user = User.find_by_email(data["email"])
      user
    else # Create an user with a stub password. 
      # timezone = data.has_key?('timezone') ? ActiveSupport::TimeZone.new(data['timezone']).name : 'UTC'
      user = User.new(:email => data['email'], :password => Devise.friendly_token[0,20])
      user.user_name = user_info['nickname'].gsub(".","-") if User.count(:conditions=>{:user_name => user_info['nickname']}) == 0
      user.save(:validate => false)
      unless user.nil?
        user.profile.download_remote_image(user_info["image"]) #user_info["image"]=>"http://graph.facebook.com/1031403115/picture?type=square"
        user.profile.last_name = user_info['last_name']
        user.profile.first_name = user_info['first_name']
        user.profile.personal_data = access_token
        user.profile.facebook_id = data['id']
        user.profile.save(:validate => false)
      end
      user
    end
  end

   def self.find_for_twitter_oauth(access_token, signed_in_resource=nil)

    access_token['extra'].delete('access_token')
    uid = access_token['uid']
    if profile = Profile.find_by_twitter_id(uid)
      profile.user
    else # Create an user with a stub password. 
     user_info = access_token['user_info']
     data = access_token['extra']['user_hash']

     user = User.new(:email => "#{uid}@twitter.com", :password => Devise.friendly_token[0,20])
     user.name = user_info['nickname'].gsub(".","-") if User.count(:conditions=>{:name => user_info['nickname']}) == 0
     user.save(:validate => false)

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
   
end
