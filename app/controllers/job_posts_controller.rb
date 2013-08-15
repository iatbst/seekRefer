class JobPostsController < ApplicationController
  before_filter :authenticate_user!, except: ["index", "show"]
  autocomplete :position, :name
  autocomplete :company, :name
  
  def index
    @job_posts = JobPost.all
  end
  
  def new
    
  end
  
  def create
    @job_post = JobPost.new(job_post_params)
    @job_post.poster_id = current_user.id
    @job_post.save
    #send email to followers 
    Thread.new { notify_followers( @job_post ) }
    
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
    @job_post = JobPost.find(params[:id])
 
    if @job_post.update(job_post_params)
      redirect_to @job_post
    else
      render 'edit'
    end
  end
  
  def destroy
    @job_post = JobPost.find(params[:id])
    @job_post.destroy
 
    redirect_to job_posts_path
  end
  
  private 
    def job_post_params
      params.require(:job_post).permit(:industry_id, :company_id, :location_id, :poster_id, :position, :content)
    end
  
    def notify_followers( post )
      @followers = User.where(id: FollowRule.select("follow_rules.follower_id").where("(company_id = ? OR company_id IS NULL) AND
                                                                                       (location_id = ? OR location_id IS NULL) AND
                                                                                       (industry_id = ? OR industry_id IS NULL) ",   post.company_id, post.location_id, post.industry_id))
      url = url_for(controller: "job_posts", action: "show", id: post.id, only_path: false)
      
      @followers.each do |follower|
        FollowMailer.notify_followers( follower, post, url).deliver 
      end
                                                                              
      
    end
end
