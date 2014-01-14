module EnlistmentHelper
  
  def contact_each_enlistment
    if @campaign.enlistment.contact_each_enlist == 0
      @result = multiply(@campaign.training_sheet.man_contact, @campaign.enlistment.contact_enlist)
    elsif @campaign.enlistment.contact_each_enlist >= 1
      @result = multiply((multiply(@campaign.training_sheet.man_contact, @campaign.enlistment.contact_enlist)), @campaign.enlistment.contact_each_enlist)
    end
    @result
  end
end
