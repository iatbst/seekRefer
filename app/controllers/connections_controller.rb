class ConnectionsController < ApplicationController
  before_filter :authenticate_user!
  def index
    #@connections = Connection.all(from: current_user.email)
    @users = User.where(email: Connect.select("connects.to").where(from: current_user.email))
    
  end





end
