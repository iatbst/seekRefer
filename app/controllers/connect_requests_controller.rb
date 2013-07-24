class ConnectRequestsController < ApplicationController
  
  def send_request
    authenticate_user!
    #first check out if request exist in database
    @user = User.find(params[:id])
    if ConnectRequest.exists?(from: current_user.email, to: @user.email)
      @message = "Connect request already sent, Can't send twice !"
      return
    end
    
    #send mail
    @token = generate_token
    ConnectRequestMailer.connect_request(@user, @token, current_user).deliver
    
    #save request to table
    @request = ConnectRequest.new(from: current_user.email, to: @user.email, token: @token, accepted: false)
    @request.save
    @message = "Connect request send to " + @user.name  
  end
  
  # handle connect accept 
  def accept_request
    # not accepted yet, accept and save relation to database
    if (request = ConnectRequest.find_by_token(params[:token]) )
      if(request.accepted == false)
        request.update(:accepted => true)
        connect1 = Connect.new(:from => request.from, :to => request.to)
        connect2 = Connect.new(:from => request.to, :to => request.from)
        connect1.save
        connect2.save
      end
      @message = "You and " + User.find_by_email(request.from).name + " are connected now, Congratulations :)"
    # not find
    else 
      @message = "Woops, this invitation has expired :("
    end   
  end
  
  
  def ignore_request
    #if receive ignore, DO NOTHING
  end
  
  def disconnect
    @user = User.find(params[:id])
    Connect.where("(connects.to = ? AND connects.from = ?) OR (connects.from = ? AND connects.to = ?)", 
                  @user.email, current_user.email, current_user.email, @user.email).destroy_all
  
  end
  
  private 
    def generate_token
      SecureRandom.urlsafe_base64
    end
    
end
