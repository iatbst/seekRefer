class UsersController < ApplicationController
  def new
  end
  
  #sign up
  def signup  
    @user = User.new
  end
  
  def index
    @users = User.all
  end 
  
  def create
    @user = User.new(params.require(:user).permit(:name, :company, :dept, :position, :email, :password, :password_confirmation))
    if @user.save
      redirect_to user_path(@user)
    else
      render 'signup'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    @user.update(params[:user].permit(:name, :company, :dept, :position, :email))
    redirect_to @user
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to companies_path
  end
  
  def connect
    @user = User.find(params[:id])
    UserMailer.connect_request(@user).deliver
  end
end
