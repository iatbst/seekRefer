class AddStatusToReferCases < ActiveRecord::Migration
  def change
    add_column :refer_cases, :status_id, :integer
  end
end
