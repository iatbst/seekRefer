class CreateUsColleges < ActiveRecord::Migration
  def change
    create_table :us_colleges do |t|
      t.string :state
      t.string :name

      t.timestamps
    end
  end
end
