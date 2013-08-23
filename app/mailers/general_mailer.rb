class GeneralMailer < ActionMailer::Base
  default from: "iatbst@gmail.com"
  
  def general_email(to, from, subject, message)
      
      @to = to
      @from = from
      @message = message
    
      mail(to: to.email, subject: subject)
    
   
  end
end
