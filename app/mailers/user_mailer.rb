class UserMailer < ActionMailer::Base
  default from: "iatbst@gmail.com"
  
  def connect_request(user)
    @user = user
    mail(to: @user.email, subject: 'You have connection request!')
  end
end
