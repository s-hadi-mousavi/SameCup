class CreateProfileForUsers < ActiveRecord::Migration
  def self.up
    User.all.each{|u| Profile.new(:user_id=>u.id).save(:validate=>false) if u.profile.nil?}
  end

  def self.down
    User.all.each{|u| u.profile.destroy}
  end
end
