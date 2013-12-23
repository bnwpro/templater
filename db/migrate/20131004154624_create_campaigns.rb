class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.integer :user_id
      t.string :name
      t.string :diocese
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :contact_name
      t.string :phone
      t.string :fax
      t.string :email
      t.string :url
      t.integer :number_of_families
      t.decimal :contribution_income, precision: 7, scale: 2
      t.boolean :has_pacesetter, default: true
      t.boolean :standalone, default: false
      
      t.timestamps
    end
  end
end
