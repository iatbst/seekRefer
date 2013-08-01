class AddColumnsToReferCases < ActiveRecord::Migration
  def change
    add_column :refer_cases, :result, :string
    add_column :refer_cases, :feedback, :integer
  end
end
