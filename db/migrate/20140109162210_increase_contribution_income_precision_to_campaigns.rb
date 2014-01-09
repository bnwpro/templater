class IncreaseContributionIncomePrecisionToCampaigns < ActiveRecord::Migration
  def change
    change_column :campaigns, :contribution_income, :decimal, precision: 14, scale: 2
  end
end
