class ConnectionsController < ApplicationController
  before_filter :authenticate_user!
  def index
    #@connections = Connection.all(from: current_user.email)
    @users = User.where(id: Connect.select("connects.to_id").where(from_id: current_user.id))
    
  end





end
