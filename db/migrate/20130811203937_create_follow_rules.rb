class CreateFollowRules < ActiveRecord::Migration
  def change
    create_table :follow_rules do |t|
      t.references :company, index: true
      t.references :location, index: true
      t.references :industry, index: true

      t.timestamps
    end
  end
end
