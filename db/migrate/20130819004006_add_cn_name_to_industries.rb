class AddCnNameToIndustries < ActiveRecord::Migration
  def change
    add_column :industries, :name_cn, :string
  end
end
