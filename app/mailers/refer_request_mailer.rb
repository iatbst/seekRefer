class ReferRequestMailer < ActionMailer::Base
  default from: "iatbst@gmail.com"
  
  def refer_request(to, from, file, intro)
    @to = to
    @from = from
    @intro = intro
    
    if @from.avatar.path(:small).nil?
      avatarPath = "public/images/users/defaultAvatar_small.png"
    else
      avatarPath = @from.avatar.path(:small)
    end
    attachments.inline['avatar.png'] = File.read(avatarPath)
    attachments[file] = File.read('users/' + from.name + '/' + file)
    attachments.inline['logo.png'] = File.read("public/images/others/seekRefer.jpg")
    mail(to: @to.email, subject: '您收到推荐请求')
  end
end
