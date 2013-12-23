class CampaignContact < ActiveRecord::Base
  
  validates :description, presence: true
  validates :phone, numericality: true, allow_blank: true
  
  belongs_to :campaign
  
end
