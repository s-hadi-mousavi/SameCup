class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, :lockable

  has_many :project_users
  has_many :projects, :through => :project_users
  has_many :stickers
        
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
end
