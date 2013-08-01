class AddIsActiveToReferCases < ActiveRecord::Migration
  def change
    add_column :refer_cases, :is_active, :boolean
  end
end
