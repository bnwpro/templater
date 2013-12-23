class GiftProfile < ActiveRecord::Base
  
  #validates :goal, numericality: true
  
  belongs_to :campaign
  
  #attr_accessor :families_total, :total_level, :cumulative_total
  
  def families_total
    @families_total
  end
  def total_level
    @total_level
  end
  def cumulative_total
    @cumulative_total
  end
  
  def families_total=(val)
    @families_total = val
    get_total
  end
  def total_level=(val)
    @total_level = val
  end
  def cumulative_total=(val)
    @cumulative_total = val
  end
  
  private
  
  def get_total
    self.families_total = @campaign.number_of_families
  end
  
end
