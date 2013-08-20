class AddTokenToConnects < ActiveRecord::Migration
  def change
    add_column :connects, :token, :string
    add_column :connects, :accepted, :boolean
  end
end
