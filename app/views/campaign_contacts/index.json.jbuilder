json.array!(@campaign_contacts) do |campaign_contact|
  json.extract! campaign_contact, :campaign_id, :description, :name, :address, :city, :state, :zip, :phone, :email
  json.url campaign_contact_url(campaign_contact, format: :json)
end
