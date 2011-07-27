class Sticker < ActiveRecord::Base
  belongs_to :user
  belongs_to :sprint
  #belongs_to :state
  belongs_to :user_story
  
  #default_scope :order => "updated_at DESC"
  
  serialize :options
  
  attr_accessor :left, :top, :color
  
  validates :description, :presence => true
  
  scope :for_sprint, lambda { |id| where("sprint_id = ?", id) }
  scope :by_state, lambda { |id| where("state_id = ?", id) }
  scope :by_project, lambda { |id| where("project_id = ?", id) }
  
  def left=(value)
    value = value.to_i >= 0 ? value.to_i : 0
    unless self.options.nil?
      self.options[:left] = value
    else
      self.options = {:left => value, :top => 0 }
    end
  end
  
  def left
    unless self.options.nil?
      self.options[:left] || 0
    else
      0
    end
  end
  
  def top
    unless self.options.nil?
      self.options[:top] || 0
    else
      0
    end
  end
  
  def top=(value)
    value = value.to_i >= 0 ? value.to_i : 0
    unless self.options.nil?
      self.options[:top] = value
    else
      self.options = {:top => value, :left => 0 }
    end
  end
  
  def color=(color)
    unless self.options.nil?
      self.options[:color] = color
    else
      self.options = {:color => color }
    end
  end
  
  def color
    unless self.options.nil?
      self.options[:color] || "#FFF046"
    else
      "#FFF046"
    end
  end
  def state_text
    "inbox"
  end
  
end
