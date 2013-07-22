class CreateConnects < ActiveRecord::Migration
  def change
    create_table :connects do |t|
      t.string :from
      t.string :to

      t.timestamps
    end
  end
end
