class TrainingSheet < ActiveRecord::Base
  
  #validates :print_contact_name, presence: true
  validates :print_contact_email, format: /.+@.+\..+/i, length: { within: 5..50}, allow_blank: true
  validates :print_contact_phone, numericality: true, allow_blank: true
  
  validates_each :man_ac, :man_camp_admin, :man_camp_chair, :man_childs_act,
    :man_contact, :man_follow_up, :man_info, :man_invlvm, :man_pace_gifts,
    :man_prayer, :man_print_comm, :man_spc_event, :man_vis_comm, :man_youth,
    :man_pastor, :ts_ac1, :ts_ac2, :ts_ac3, :ts_ct1, :ts_ct2, :ts_ct3,
    :ts_ct4, :ts_ct5, :ts_ct6, :ts_ct7, :ts_it1, :ts_it2 do |record, attr, value|
      record.errors.add(attr, 'Quantity of Training Sheets cannot be blank') if value == nil
    end
  
  belongs_to :campaign
end
