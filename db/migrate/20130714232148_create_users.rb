class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :company, index: true
      t.string :dept
      t.string :position

      t.timestamps
    end
  end
end
