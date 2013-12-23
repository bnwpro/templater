class CreateCampaignContacts < ActiveRecord::Migration
  def change
    create_table :campaign_contacts do |t|
      t.integer :campaign_id
      t.index :campaign_id
      t.string :description
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
