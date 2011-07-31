class Profile < ActiveRecord::Base
  
  belongs_to :user
  serialize :params

end
