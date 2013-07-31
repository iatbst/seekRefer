class ReferCasesController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    referral = User.find(params[:id])
    @case = ReferCase.new(referrer:current_user.email, referral:referral.email, status:"准备递交简历")
    @case.save
    
    redirect_to refer_cases_show_referrer_path
  end
  
  #show all cases in which current user is referrer
  def show_referrer
    @cases = ReferCase.all(:conditions => "referrer = '#{current_user.email}'")
  end
  
  #show all cases in which current user is referral
  def show_referral
    @cases = ReferCase.all(:conditions => "referral = '#{current_user.email}'")
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
end
