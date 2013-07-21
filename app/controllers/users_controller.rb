class UsersController < ApplicationController
  before_filter :require_admin, except: [:show, :connect]
  
  def require_admin
    redirect_to new_user_session_path unless current_user && current_user.admin?
  end
  
  def new
    @user = User.new
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
      flash[:success] = "Add User: " + params[:user][:name] + " to DB!"
      redirect_to @user
    else
      render 'new'
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
   
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :company, :dept, :position,
                                   :password_confirmation)
    end
end
