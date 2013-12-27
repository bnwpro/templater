class CampaignContact < ActiveRecord::Base
  
  validates :description, presence: true
  validates :phone, numericality: true, allow_blank: true
  validates :email, format: /.+@.+\..+/i, uniqueness: true, length: { within: 5..50}
  
  belongs_to :campaign
  
end
