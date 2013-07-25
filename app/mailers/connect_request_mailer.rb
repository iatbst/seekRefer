class ConnectRequestMailer < ActionMailer::Base
  default from: "iatbst@gmail.com"
  
  def connect_request(to, token, from)
    @to = to
    @token = token
    @from = from
    if @from.avatar.path(:small).nil?
      avatarPath = "public/images/users/defaultAvatar_small.png"
    else
      avatarPath = @from.avatar.path(:small)
    end
    attachments.inline['avatar.png'] = File.read(avatarPath)
    attachments.inline['logo.png'] = File.read("public/images/others/seekRefer.jpg")
    mail(to: @to.email, subject: 'you have connection request')
  end
end
