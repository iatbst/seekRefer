class FollowMailer < ActionMailer::Base
  default from: "iatbst@gmail.com"
  
  def notify_followers(follower, post, url)
      
      @post = post
      @url = url
    
      mail(to: follower.email, subject: 'New Job Openning')
    
   
  end

end
