class State < ActiveRecord::Base
  belongs_to :project
  default_scope :order => "id DESC"
end
