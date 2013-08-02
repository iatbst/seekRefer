class CreateReferPosts < ActiveRecord::Migration
  def change
    create_table :refer_posts do |t|
      t.references :refer_case_id, index: true
      t.references :user_id, index: true
      t.string :content

      t.timestamps
    end
  end
end
