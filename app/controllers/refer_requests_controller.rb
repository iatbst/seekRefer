class ReferRequestsController < ApplicationController
  def send_request
    @to = User.find(params[:id])
    @to.id
  end
  
  def recv_request
    # save attached resume pdf to local user personal folder
    uploaded_io = params[:refer_request][:resume]
    File.open(Rails.root.join('users', 'JoshuaY', uploaded_io.original_filename), 'wb+') do |file|
      file.write(uploaded_io.read)
    end
    
    # send mail out
    @to = User.find(params[:id])
    ReferRequestMailer.refer_request(@to, current_user, uploaded_io.original_filename).deliver
    
  end
end
