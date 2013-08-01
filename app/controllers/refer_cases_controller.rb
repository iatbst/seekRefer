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
    @case = ReferCase.find(params[:id])
    if(params[:referrer] == "true")
      @referrer = true
    else
      @referrer = false
    end
    
  end
  
  # update case status
  def update
    @case = ReferCase.find(params[:id])
    @case.update(status: params["refer_case"][:status])
    redirect_to action: "edit", id: @case.id, referrer: params[:referrer]
  end
  
  def destroy
    @case = ReferCase.find(params[:id])
    @case.destroy
    redirect_to root_path
  end
end
