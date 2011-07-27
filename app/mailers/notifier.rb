class Notifier < ActionMailer::Base
  default :from => "support@samecup.com"
  @@from = "SameCup <support@samecup.com>"
  
  def user_invitation(user, project)
    recipients user.email
         subject    "You are invited on '#{project.name}' project"
         from       @@from
         body       :project =>project, :user=>user
         content_type "text/html"
  end
  def user_feedback(params, agent)
    email = params[:email]
    comment = params[:comment]
    comment = comment.gsub(/\n/, '<br>')
    
    recipients @@from
         subject    "Feedback '#{email}' project"
         from       email
         body       :email => email, :comment => comment, :agent => agent
         content_type "text/html"
  end
  

end
