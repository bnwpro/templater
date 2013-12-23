class AddIndexToSqlTemplates < ActiveRecord::Migration
  def change
    add_index :sql_templates, :campaign_id
  end
end
