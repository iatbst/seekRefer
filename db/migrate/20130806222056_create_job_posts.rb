class CreateJobPosts < ActiveRecord::Migration
  def change
    create_table :job_posts do |t|
      t.references :industry, index: true
      t.references :company, index: true
      t.references :location, index: true
      t.string :position

      t.timestamps
    end
  end
end
