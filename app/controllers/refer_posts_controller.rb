class ReferPostsController < ApplicationController
  # create new post 
  def create
    content = params[:refer_post][:content]
    
    @post = ReferPost.new(content: content, user_id: current_user.id, refer_case_id: params[:refer_case_id])
    @post.save
    
    redirect_to :back
  end
end
