class ConnectRequestsController < ApplicationController
  def send
    authenticate_user!
    @user = User.find(params[:id])
    UserMailer.connect_request(@user).deliver
    
    #save request to table
    @request = ConnectRequest.new(from: current_user.email, to: @user.email)
    @request.save
  end
end
