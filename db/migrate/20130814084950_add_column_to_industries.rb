class AddColumnToIndustries < ActiveRecord::Migration
  def change
    add_column :industries, :code, :integer
  end
end
