class Profile < ActiveRecord::Base

  belongs_to :profile
  serialize :params

end
