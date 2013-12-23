class AddIndexToCampaigns < ActiveRecord::Migration
  def change
    add_index :campaigns, :user_id
  end
end
