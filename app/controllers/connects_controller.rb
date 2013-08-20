class ConnectsController < ApplicationController
  before_filter :authenticate_user!, :except => [:accept_request]
  def index
    #@connections = Connection.all(from: current_user.email)
    #@users = User.where(id: Connect.select("connects.to_id").where(from_id: current_user.id))
    @users = current_user.connect_users
  end

  # send connect request 
  def send_request
    authenticate_user!
    #first check out if request exist in database
    @user = User.find(params[:id])
    
    #send mail
    @token = generate_token
    ConnectRequestMailer.connect_request(@user, @token, current_user).deliver
    
    #save request to table
    @connect = Connect.new(from_id: current_user.id, to_id: @user.id, token: @token, accepted: false)
    @connect.save
    
    redirect_to :back
  end
  
  # handle connect accept 
  def accept_request
    # not accepted yet, accept and save relation to database
    if (connect = Connect.find_by_token(params[:token]) )
      if(connect.accepted == false)
        connect.update(:accepted => true)
        # add another pair to speed up connects lookup, not smart though
        Connect.create(from_id: connect.to_id, to_id: connect.from_id, accepted: true)
      end
      @message = "You and " + connect.from.name + " are connected now, Congratulations :)"
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
                  @user.id, current_user.id, @user.id, current_user.id).destroy_all
  
    redirect_to :back
  end


  # check if A and B is connected ? or request sent ? or new with each other ? return 0 or 1 or 2
  # return 2: already connected 
  # return 1: request sent, not be accepted yet
  # return 0: new to each other 
  def self.if_connected(from, to)
    connect = Connect.where(from_id:from, to_id:to).first
    connect_ = Connect.where(from_id:to, to_id:from, accepted:true).first
    
    if connect_.nil?
      if connect.nil?
        return 0
      elsif connect.accepted
        return 2
      else
        return 1
      end
    else
      return 2
    end
   end
   
  private 
    def generate_token
      SecureRandom.urlsafe_base64
    end
end
