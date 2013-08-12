class FollowRulesController < ApplicationController
  def index
    @follow_rules = FollowRule.where(follower_id: current_user.id)
    
  end
  
  def new
    
  end
  
  def create
    @follow_rule = FollowRule.new(follow_rule_params)
    @follow_rule.follower_id = current_user.id
    @follow_rule.save
    redirect_to follow_rules_path 
  end
  
  def edit
    @follow_rule = FollowRule.find(params[:id])    
  end
  
  def update
    @follow_rule = FollowRule.find(params[:id])
 
    if @follow_rule.update(follow_rule_params)
      redirect_to follow_rules_path
    else
      render 'edit'
    end   
  end
  
  def show
    
  end
  
  def destroy
    @follow_rule = FollowRule.find(params[:id])
    @follow_rule.destroy
 
    redirect_to follow_rules_path   
  end
  
  private 
    def follow_rule_params
      params.require(:follow_rule).permit(:industry_id, :company_id, :location_id)
    end
  
  
end
