class UserStory < ActiveRecord::Base
  belongs_to :sprint
  has_many :stickers, :dependent => :destroy
  
  default_scope :order => "updated_at DESC"
  
  validates :title, :presence => true
  validates :description, :presence => true
end
