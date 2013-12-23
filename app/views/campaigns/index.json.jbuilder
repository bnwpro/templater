json.array!(@campaigns) do |campaign|
  json.extract! campaign, :user_id, :name, :diocese, :address, :city, :state, :zip, :contact_name, :phone, :fax, :email, :url, :number_of_families, :contribution_income, :has_pacesetter, :standalone
  json.url campaign_url(campaign, format: :json)
end
