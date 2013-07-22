class ConnectRequestMailer < ActionMailer::Base
  default from: "iatbst@gmail.com"
  
  def connect_request(user, token)
    @user = user
    @token = token
    mail(to: @user.email, subject: 'You have connection request!')
  end
end
