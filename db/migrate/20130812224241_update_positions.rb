class UpdatePositions < ActiveRecord::Migration
  def change
    remove_column :positions, :name
    add_reference :positions, :name, index: true
  end
end
