class ChangeColumnJobPosts < ActiveRecord::Migration
  def change
    change_column :job_posts, :content, :text
  end
end
