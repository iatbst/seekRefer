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
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
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
    
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
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
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :company, :dept, :position,
                                   :password_confirmation)
    end
end
