class RenameColumnForReferPost < ActiveRecord::Migration
  def change
    rename_column :refer_posts, :user_id_id, :user_id
    rename_column :refer_posts, :refer_case_id_id, :refer_case_id 
  end
end
