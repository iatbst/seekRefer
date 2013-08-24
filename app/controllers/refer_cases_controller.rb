class ReferCasesController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    request = ReferRequest.find_by_token(params[:token])
    #　no refer request record in DB
    if request.nil?
      @message = "相关refer请求已经过期!!!"
      render 'shared/error.html.erb', :message => @message and return 
    end
    # repeated acceptance 
    if request.accepted 
      @message = "您已经接受了该refer请求!!!"
      render 'shared/error.html.erb', :message => @message and return      
    end
    request.accepted = true
    request.save
    
    referral = request.from
    #@case = ReferCase.new(referrer_id: current_user.id, referral_id: referral.id, status:"准备递交简历")
    #@case.save
    @case = current_user.referrer_cases.create(referral_id: referral.id, status_id: 1, status:"准备递交简历", is_active: true)
    redirect_to refer_cases_show_referrer_path
  end
  
  #show all cases in which current user is referrer, which are active now
  def show_referrer
    #@cases = ReferCase.all(:conditions => "referrer_id = '#{current_user.id}'")
    @cases = current_user.referrer_cases.where(is_active: true)
  end
  
  #show all old cases which are already closed
  def show_referrer_old
    @cases = current_user.referrer_cases.where(is_active: false)
  end
  
  #show all cases in which current user is referral
  def show_referral
    #@cases = ReferCase.all(:conditions => "referral_id = '#{current_user.id}'")
    @cases = current_user.referral_cases.where(is_active: true)
  end
  
  #show all old cases which are already closed
  def show_referral_old
    @cases = current_user.referral_cases.where(is_active: false)
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
    status = params["refer_case"][:status]
    case status
    when "准备递交简历"
      status_id = 1
    when "简历已递交"
      status_id = 2
    when "HR已联系"
      status_id = 3
    when "面试中"
      status_id = 4
    when "通知面试结果"
      status_id = 5
    end
    @case.update(status: status, status_id: status_id)
    redirect_to :back
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
