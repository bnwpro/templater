class TrainingSheet < ActiveRecord::Base
  
  #validates :print_contact_name, presence: true
  validates :print_contact_email, format: /.+@.+\..+/i, length: { within: 5..50}, allow_blank: true
  validates :print_contact_phone, numericality: true, allow_blank: true
  
  belongs_to :campaign
end
