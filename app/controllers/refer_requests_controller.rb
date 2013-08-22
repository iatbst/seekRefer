class ReferRequestsController < ApplicationController
  before_filter :authenticate_user!, except: ["view_profile", "ignore_request"]
  
  def send_request
    @to = User.find(params[:id])
    
    render :layout => false
  end
  
  def recv_request
    # save attached resume pdf to local user personal folder
    if params[:refer_request][:old_resume] == "0"
      uploaded_io = params[:refer_request][:resume]
      # no resume uploaded
      if uploaded_io.nil?
        @message = "请上传简历或者勾选'使用已经上传简历' !!! "
        render 'shared/error.html.erb', :message => @message and return
      end
      
      # if user folder not exist, create one 
      if not File.directory?(Rails.root.join('public', 'users', current_user.name))
        FileUtils.mkdir(Rails.root.join('public', 'users', current_user.name))
      end
      
      File.open(Rails.root.join('public', 'users', current_user.name, "resume.pdf"), 'wb+') do |file|
        file.write(uploaded_io.read)
      end
    else
      # check the box to use old file which not uploaded yet
      if not File.exists? Rails.root.join('public', 'users', current_user.name, "resume.pdf")
        @message = "服务器上没有您的简历，请上传简历 !!! "
        render 'shared/error.html.erb', :message => @message and return
      end
    end
     
    # save request to DB
    @token = generate_token
    @to = User.find(params[:id])
    @request = ReferRequest.new(from_id: current_user.id, to_id: @to.id, token: @token, accepted: false)
    @request.save
    
    
    # send mail out
    ReferRequestMailer.refer_request(@to, current_user, params[:refer_request][:intro], @token).deliver
    
    redirect_to :back
  end
  
  # handle "view profile" request from refer provider
  def view_profile
    # not accepted yet, accept and save relation to database
    if (request = ReferRequest.find_by_token(params[:token]) )
      @applicant = request.from
      # check if resume in user folder
      if not File.exists? Rails.root.join('public', 'users', @applicant.name, "resume.pdf")
        @message = "Woops, 她/他的简历不在服务器上面 !!!"
        render 'shared/error.html.erb', :message => @message
      end
      
    # not find
    else
      @message = "Woops, this invitation has expired :("
      render 'shared/error.html.erb', :message => @message
     
    end
  end
  
  # upload resume to server
  def upload_resume
    render 'shared/upload_resume.html.erb'
  end
  
  def save_resume
      uploaded_io = params[:upload_resume][:resume]
      # no resume uploaded
      if uploaded_io.nil?
        @message = "上传失败，请重新上传 !!! "
        render 'shared/error.html.erb', :message => @message and return
      end
     
      # if user folder not exist, create one 
      if not File.directory?(Rails.root.join('public', 'users', current_user.name))
        FileUtils.mkdir(Rails.root.join('public', 'users', current_user.name))
      end
      
      File.open(Rails.root.join('public', 'users', current_user.name, "resume.pdf"), 'wb+') do |file|
        file.write(uploaded_io.read)
      end   
      
      @message = "简历上传成功 !!! "
      render 'shared/inform.html.erb', :message => @message 
  end
  
  
  def ignore_request
    #if receive ignore, DO NOTHING
    request = ReferRequest.find_by_token(params[:token])
    if request.nil?
      @message = "您忽略了此Ｒefer请求　!!!"
    else
      @message = "您忽略了来自" + request.from.name + "的Ｒefer请求　!!!"
    end
    
    render 'shared/error.html.erb', :message => @message
  end
  
  # check out if current user could send refer request or not, depend on when the last request was sent
  # return true , no record or record expired, ok to send request now
  # return false, record found and not expire yet, not able to send request now
  def self.ok_to_send( from, to)
    request = ReferRequest.where("from_id = ? AND to_id = ? AND created_at > ?", from, to, 90.days.ago).first
    
    if request.nil?
      return true
    else
      return false
    end
      
  
  end
  
  
  private
    def generate_token
      SecureRandom.urlsafe_base64
    end
    
end