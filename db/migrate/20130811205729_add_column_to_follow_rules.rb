class AddColumnToFollowRules < ActiveRecord::Migration
  def change
    add_reference :follow_rules, :follower, index: true
  end
end
