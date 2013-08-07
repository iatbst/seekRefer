class AddContentToJobPosts < ActiveRecord::Migration
  def change
    add_column :job_posts, :content, :string
  end
end
