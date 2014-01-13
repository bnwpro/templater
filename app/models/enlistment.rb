class Enlistment < ActiveRecord::Base
  belongs_to :campaign
  
  validates_each :ac_enlist, :childs_act_enlist, :spc_event_enlist, :contact_enlist, :contact_each_enlist, :info_enlist do |record, attr, value|
    record.errors.add(attr, 'Enlistment quantity cannot be blank') if value == nil
  end
  
  def vir_var
    ac_enlist
  end
end
