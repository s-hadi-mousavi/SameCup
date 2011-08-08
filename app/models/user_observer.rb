class UserObserver < ActiveRecord::Observer

  def before_validate(user)
  end
  
  def before_create(user)
  end
  
  def after_create(user)
    #create default public group for each user
    Profile.new(:user_id=>user.id).save(:validate=>false)
  end
  
  def before_destroy(user)
    
  end
  def after_destroy(user)
    #remove all links to projects
    ProjectUser.delete_all(["user_id = ?", user.id])
  end
  
end