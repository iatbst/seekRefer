class AddTagsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :tags, :text
  end
end
