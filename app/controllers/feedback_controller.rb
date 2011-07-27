class FeedbackController < ApplicationController

def post
  agent = request.env["HTTP_USER_AGENT"]
  
  begin
    Notifier.deliver_user_feedback(params, agent)
  rescue
    puts "ERROR: #{$!}"
  end
  
end

end
