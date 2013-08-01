class ConnectRequestsController < ApplicationController
  
  def send_request
    authenticate_user!
    #first check out if request exist in database
    @user = User.find(params[:id])
    if ConnectRequest.exists?(from_id: current_user.id, to_id: @user.id)
      @message = "Connect request already sent, Can't send twice !"
      return
    end
    
    #send mail
    @token = generate_token
    ConnectRequestMailer.connect_request(@user, @token, current_user).deliver
    
    #save request to table
    @request = ConnectRequest.new(from_id: current_user.id, to_id: @user.id, token: @token, accepted: false)
    @request.save
    @message = "Connect request send to " + @user.name  
  end
  
  # handle connect accept 
  def accept_request
    # not accepted yet, accept and save relation to database
    if (request = ConnectRequest.find_by_token(params[:token]) )
      if(request.accepted == false)
        request.update(:accepted => true)
        connect1 = Connect.new(:from_id => request.from.id, :to_id => request.to.id)
        connect2 = Connect.new(:from_id => request.to.id, :to_id => request.from.id)
        connect1.save
        connect2.save
      end
      @message = "You and " + request.from.name + " are connected now, Congratulations :)"
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
    Connect.where("(connects.to_id = ? AND connects.from_id = ?) OR (connects.from_id = ? AND connects.to_id = ?)", 
                  @user.id, current_user.id, current_user.id, @user.id).destroy_all
  
  end
  
  private 
    def generate_token
      SecureRandom.urlsafe_base64
    end
    
end
