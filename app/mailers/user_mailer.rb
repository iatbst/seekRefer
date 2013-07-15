class UserMailer < ActionMailer::Base
  default from: "connectRequest@refer.com"
  
  def connect_request(user)
    @user = user
    mail(to: @user.email, subject: 'You have connection request!')
  end
end
