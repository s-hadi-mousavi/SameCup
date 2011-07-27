class Sprint < ActiveRecord::Base
  belongs_to :project
  has_many :stickers, :dependent => :destroy
  has_many :user_stories, :dependent => :destroy
  
  default_scope :order => 'end_at DESC'
  scope :for_project, lambda { |id| where("project_id = ?", id) }
  
  validates :name, :presence => true
  #validates :end_at, :later_than_start_at => true, :presence => true
  validates :start_at, :presence => true
  validate :validate_start_at
  validate :validate_end_at
  
  def validate_start_at
    unless id.nil?
      found = Sprint.count_by_sql("SELECT COUNT(1) FROM sprints WHERE start_at < '#{start_at}' AND end_at >'#{start_at}' AND id <> #{id} AND project_id = #{project_id}")
      errors.add :start_at, ' can\'t start inside other sprint' if found > 0
    end
  end
  def validate_end_at
    unless id.nil?
      errors.add :end_at, ' can not ends before start' if end_at < start_at
      found = Sprint.count_by_sql("SELECT COUNT(1) FROM sprints WHERE start_at < '#{end_at}' AND end_at >'#{end_at}' AND id <> #{id} AND project_id = #{project_id}")
      errors.add :end_at, ' can\'t end inside other sprint' if found > 0
    end
  end
end
