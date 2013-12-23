class Enlistment < ActiveRecord::Base
  belongs_to :campaign
  
  def vir_var
    ac_enlist
  end
end
