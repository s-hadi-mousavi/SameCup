class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, :lockable, :omniauthable,
         :encryptable, :encryptor => :sha1

  #projects stuff
  has_many :projects, :through => :project_users
  has_many :project_users #will be destroyed in projects
  has_many :own_projects, :class_name=>'Project', :foreign_key => 'owner_id', :dependent=>:destroy #destroy all own projects 
  #stickers
  has_many :stickers
  has_one :profile, :dependent => :destroy

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
