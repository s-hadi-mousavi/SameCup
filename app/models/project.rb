class Project < ActiveRecord::Base
  
  belongs_to :owner, :class_name => "User"
  has_many :members, :class_name => "ProjectUser"
  has_many :users, :through => :members
  has_many :states
  has_many :sprints
  has_many :sprint_reports
  has_many :stickers, :class_name => "Sticker"

  
  # accepts_nested_attributes_for :states, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
  
  validates :name, :presence => true
  validates :alias, :presence => true, :uniqueness => true, :format => { :with => /^(\w|-)+$/ }
  
  def member? user
    self.users.include? user
  end
  def members_with_first user
    members = self.users
    members.delete_if{|u| u.id == user.id}
    members.insert(0, user)
  end
    
  def current_sprint
    #if no sprint is sent, then try to find most accurate
    sprint = sprints.find(:first , :conditions => ["created_at<=? AND end_at>=?", Time.now, Time.now] ,:order=> 'end_at DESC')
    #if no sprint in middle of now found, then get last one
    sprint = sprints.find(:first,:order=> 'end_at DESC') if sprint.nil?
    sprint
  end
  
  def to_param
    self.alias
  end
  
end
