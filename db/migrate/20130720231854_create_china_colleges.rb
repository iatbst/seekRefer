class CreateChinaColleges < ActiveRecord::Migration
  def change
    create_table :china_colleges do |t|
      t.string :province
      t.string :name

      t.timestamps
    end
  end
end
