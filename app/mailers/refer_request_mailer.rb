class ReferRequestMailer < ActionMailer::Base
  default from: "iatbst@gmail.com"
  
  def refer_request(to, from, file, intro)
    @to = to
    @from = from
    @intro = intro
    attachments[file] = File.read('users/' + from.name + '/' + file)
    mail(to: @to.email, subject: '您收到推荐请求')
  end
end
