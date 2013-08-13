class FixPositions < ActiveRecord::Migration
  def change
    #remove_column :positions, :name_id
    add_column :positions, :name, :string 
    remove_column :job_posts, :position
    add_reference :job_posts, :position, index: true
  end
end
