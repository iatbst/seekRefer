class ConnectRequestMailer < ActionMailer::Base
  default from: "iatbst@gmail.com"
  
  def connect_request(user, token, from)
    @user = user
    @token = token
    @from = from
    mail(to: @user.email, subject: 'You have connection request!')
  end
end
