class CreateChinaCities < ActiveRecord::Migration
  def change
    create_table :china_cities do |t|
      t.string :province
      t.string :city

      t.timestamps
    end
  end
end
