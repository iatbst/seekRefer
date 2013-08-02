class ReferCasesController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    referral = User.find(params[:id])
    #@case = ReferCase.new(referrer_id: current_user.id, referral_id: referral.id, status:"准备递交简历")
    #@case.save
    @case = current_user.referrer_cases.create(referral_id: referral.id, status:"准备递交简历", is_active: true)
    redirect_to refer_cases_show_referrer_path
  end
  
  #show all cases in which current user is referrer
  def show_referrer
    #@cases = ReferCase.all(:conditions => "referrer_id = '#{current_user.id}'")
    @cases = current_user.referrer_cases.where(is_active: true)
  end
  
  #show all cases in which current user is referral
  def show_referral
    #@cases = ReferCase.all(:conditions => "referral_id = '#{current_user.id}'")
    @cases = current_user.referral_cases.where(is_active: true)
  end
  
  def edit
    @case = ReferCase.find(params[:id])
    if(params[:referrer] == "true")
      @referrer = true
    else
      @referrer = false
    end
    
    @posts = @case.refer_posts
    
  end
  
  # update case status
  def update
    @case = ReferCase.find(params[:id])
    @status = params["refer_case"][:status]
    @case.update(status: params["refer_case"][:status])
    redirect_to action: "edit", id: @case.id, referrer: params[:referrer]
  end
  
  # close dialog popup and give feedback to referrer
  def feedback
    @case = ReferCase.find(params[:id])  
    
    render :layout => false 
  end
  
  def destroy
    @case = ReferCase.find(params[:id])
    @case.update(is_active: false)
    @case.update(params.require(:refer_case).permit(:result, :feedback))
    redirect_to root_path
  end
end
