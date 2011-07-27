class LaterThanStartAtValidator < ActiveModel::EachValidator  
  def validate_each(object, attribute, value)  
    if value.nil? or object.start_at.nil? or value < object.start_at  
      object.errors[attribute] << (options[:message] || "must be later than start date")  
    end  
  end  
end