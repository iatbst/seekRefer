class AddPosterToJobPosts < ActiveRecord::Migration
  def change
    add_reference :job_posts, :poster, index: true
  end
end
