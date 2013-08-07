class JobPostsController < ApplicationController
  before_filter :authenticate_user!, except: ["index", "show"]
  
  def index
    @job_posts = JobPost.all
  end
  
  def new
    
  end
  
  def create
    @job_post = JobPost.new(job_post_params)
    @job_post.poster_id = current_user.id
    @job_post.save
    redirect_to job_posts_path    
  end
  
  def edit
    @job_post = JobPost.find(params[:id])
  end
  
  def show
    
    if params.has_key?("signedin") 
      authenticate_user!
    end
    @job_post = JobPost.find(params[:id])
  end
  
  def update
    authenticate_user!
    @job_post = JobPost.find(params[:id])
 
    if @job_post.update(job_post_params)
      redirect_to @job_post
    else
      render 'edit'
    end
  end
  
  def destroy
    authenticate_user!
    @job_post = JobPost.find(params[:id])
    @job_post.destroy
 
    redirect_to job_posts_path
  end
  
  private 
    def job_post_params
      params.require(:job_post).permit(:industry_id, :company_id, :location_id, :poster_id, :position, :content)
    end
  
end
