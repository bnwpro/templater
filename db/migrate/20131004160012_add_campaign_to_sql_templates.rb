class AddCampaignToSqlTemplates < ActiveRecord::Migration
  def change
    add_column :sql_templates, :campaign_id, :integer
  end
end
