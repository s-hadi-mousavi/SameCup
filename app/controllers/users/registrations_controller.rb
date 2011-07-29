class Users::RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    unless APP_CONFIG['closed_registration'] 
      super
    end
  end

  def show
  end

  def update
    super
  end
end