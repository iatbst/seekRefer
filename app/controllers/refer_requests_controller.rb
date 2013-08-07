class ReferRequestsController < ApplicationController
  before_filter :authenticate_user!, except: ["view_profile", "ignore_request"]
  
  def send_request
    @to = User.find(params[:id])
    
    render :layout => false
  end
  
  def recv_request
    # save attached resume pdf to local user personal folder
    uploaded_io = params[:refer_request][:resume]
    File.open(Rails.root.join('public', 'users', current_user.name, "resume.pdf"), 'wb+') do |file|
      file.write(uploaded_io.read)
    end
    
    # save request to DB
    @token = generate_token
    @to = User.find(params[:id])
    @request = ReferRequest.new(from_id: current_user.id, to_id: @to.id, token: @token, accepted: false)
    @request.save
    
    
    # send mail out
    ReferRequestMailer.refer_request(@to, current_user, params[:refer_request][:intro], @token).deliver
    
  end
  
  # handle "view profile" request from refer provider
  def view_profile
    # not accepted yet, accept and save relation to database
    if (request = ReferRequest.find_by_token(params[:token]) )
      @applicant = request.from
    # not find
    else 
      @message = "Woops, this invitation has expired :("
    end   
    
    
  end
  
  
  def ignore_request
    #if receive ignore, DO NOTHING
  end
  
  
  private 
    def generate_token
      SecureRandom.urlsafe_base64
    end
    
end
