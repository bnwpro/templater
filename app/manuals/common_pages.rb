class CommonPages < Manual
  
  attr_accessor :user, :campaign, :gift_profile
  attr_accessor :tier_1_gifts, :tier_2_gifts, :tier_3_gifts, :tier_1_total_amount, :tier_2_total_amount, :tier_3_total_amount
  
  def create_common_pages(options = {})
    block_calendar = options[:cal]
    manual_common_pages = options[:manual_common_pages]
    campaign_dir = options[:campaign_dir]
    appendices_dir = "pdfs/templates/appendices"
    self.user = options[:user]
    self.campaign = options[:campaign]
    self.gift_profile = campaign.gift_profile
    self.tier_1_gifts = [gift_profile.t1_gifts_1, gift_profile.t1_gifts_2, gift_profile.t1_gifts_3, gift_profile.t1_gifts_4, gift_profile.t1_gifts_5, gift_profile.t1_gifts_6]
    self.tier_2_gifts = [gift_profile.t2_gifts_1, gift_profile.t2_gifts_2, gift_profile.t2_gifts_3, gift_profile.t2_gifts_4, gift_profile.t2_gifts_5, gift_profile.t2_gifts_6, gift_profile.t2_gifts_7]
    self.tier_3_gifts = [gift_profile.t3_gifts_1, gift_profile.t3_gifts_2, gift_profile.t3_gifts_3, gift_profile.t3_gifts_4, gift_profile.t3_gifts_5, gift_profile.t3_gifts_6]
    self.tier_1_total_amount = [gift_profile.t1_gift_amount_1, gift_profile.t1_gift_amount_2, gift_profile.t1_gift_amount_3, gift_profile.t1_gift_amount_4, gift_profile.t1_gift_amount_5, gift_profile.t1_gift_amount_6]
    self.tier_2_total_amount = [gift_profile.t2_gift_amount_1, gift_profile.t2_gift_amount_2, gift_profile.t2_gift_amount_3, gift_profile.t2_gift_amount_4, gift_profile.t2_gift_amount_5, gift_profile.t2_gift_amount_6, gift_profile.t2_gift_amount_7]
    self.tier_3_total_amount = [gift_profile.t3_gift_amount_1, gift_profile.t3_gift_amount_2, gift_profile.t3_gift_amount_3, gift_profile.t3_gift_amount_4, gift_profile.t3_gift_amount_5, gift_profile.t3_gift_amount_6]
     
    Prawn::Document.generate("#{campaign_dir}/common_pages.pdf", {:page_size => 'LETTER', :skip_page_creation => true}) do |pdf|
      PdfMerger.get_template_to_merge(pdf: pdf, path: manual_common_pages[1]) # Index / Contact page
      self.add_contacts_data(pdf)
      
      PdfMerger.get_template_to_merge(pdf: pdf, path: manual_common_pages[2]) # upto Gift Profile page
      PdfMerger.get_template_to_merge(pdf: pdf, path: manual_common_pages[3]) # Gift Profile Chart
      self.add_gift_profile_data(pdf)
      
      PdfMerger.get_template_to_merge(pdf: pdf, path: block_calendar)
    end
    
    Prawn::Document.generate("#{campaign_dir}/common_pages_enlist.pdf", {:page_size => 'LETTER', :skip_page_creation => true}) do |pdf|
      string = "(Enlistment - <page>)"
      options = { :at => [bounds.right - 125, -5],
        :width => 100,
        :align => :right,
        :size => 11,
        :style => :italic }
      PdfMerger.get_template_to_merge(pdf: pdf, path: manual_common_pages[4]) # upto Enlistment page 1
      self.add_enlistment_page1_data(pdf)
      
      PdfMerger.get_template_to_merge(pdf: pdf, path: manual_common_pages[5]) # Enlistment page 2
      self.add_enlistment_page2_data(pdf)
      
      PdfMerger.get_template_to_merge(pdf: pdf, path: manual_common_pages[6]) # upto Involvement pages
      pdf.number_pages string, options
    end
    
    Prawn::Document.generate("#{campaign_dir}/giving_potential.pdf", {:page_size => 'LETTER', :skip_page_creation => true}) do |pdf|
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/common/giving_potential.pdf")
      self.add_giving_potential_data(pdf)
    end
  end
  
  # Contact Page Data
  def add_contacts_data(pdf)
    campaign.campaign_contacts.count <= 2 ? size = 12 : size = 11
    pdf.default_leading 5
    pdf.bounding_box([75, 645], :width => 385) do
      pdf.text "#{user.name}", :align => :center, :size => 12
      pdf.move_down 40
      pdf.text "#{number_to_phone(user.phone, :area_code => true)}", :align => :center, :size => 12
      pdf.move_down 20
      pdf.text "#{user.email}", :align => :center, :size => 12
    end
    pdf.default_leading 1
    pdf.bounding_box([75, 350], :width => 385) do
      campaign.campaign_contacts.each do |contact|
        pdf.text "#{contact.description}", :align => :center, :size => size
        pdf.text "#{contact.name}", :align => :center, :size => size
        pdf.text "#{contact.address}, #{contact.city}, #{contact.state} #{contact.zip}", :align => :center, :size => size
        pdf.text "#{number_to_phone(contact.phone, :area_code => true)}", :align => :center, :size => size
        pdf.text "#{contact.email}", :align => :center, :size => size
        pdf.move_down 10
      end
    end
    pdf.default_leading 5
    pdf.bounding_box([75, 100], :width => 385) do
      pdf.text "#{campaign.training_sheet.print_contact_name}", :align => :center, :size => 12
      pdf.text "#{number_to_phone(campaign.training_sheet.print_contact_phone, :area_code => true)}", :align => :center, :size => 12
      pdf.text "#{campaign.training_sheet.print_contact_email}", :align => :center, :size => 12
    end
    #pdf.formatted_text_box [{ :text => "Click for an online version of this document",
    #  :color => "0000FF", :link => "https://link.com"}], :at => [20, 20]
  end
 
  def add_gift_profile_data(pdf)
    pdf.bounding_box([35, 680], :width => 470) do
      pdf.text "#{campaign.name}", :size => 18, :style => :bold, :align => :center
      pdf.move_down 5
      pdf.text "#{campaign.city}, #{campaign.state}", :size => 12, :style => :bold, :align => :center
      pdf.move_down 35
      pdf.text "#{number_to_currency(gift_profile.goal, :precision => 0)}", :size => 18, :style => :bold, :align => :center
    end
    
    # NUMBER OF GIFTS TIER 1-3
    pdf.default_leading 2
    pdf.bounding_box([75, 515], :width => 20) do
      tier_1_gifts.each do |gifts|
        if gifts > 0
          pdf.text "#{gifts}", :size => 12, :style => :bold, :align => :center
          pdf.move_down 1
        end
      end
    end
    pdf.default_leading 0
    pdf.bounding_box([75, 357], :width => 20) do
      tier_2_gifts.each do |gifts|
        if gifts > 0
          pdf.text "#{gifts}", :size => 12, :style => :bold, :align => :center
          pdf.move_down 1
        end
      end
    end
    pdf.bounding_box([70, 175], :width => 30) do
      tier_3_gifts.each do |gifts|
        if gifts > 0
          pdf.text "#{gifts}", :size => 12, :style => :bold, :align => :center
          pdf.move_down 1
        end
      end
      pdf.text "Many"
    end
    # GIFT AMOUNTS TIER 1-3
    pdf.default_leading 2
    pdf.bounding_box([150, 515], :width => 75) do
      tier_1_total_amount.each do |amounts|
        if amounts > 0
          pdf.text "#{number_to_currency(amounts, :precision => 0)}", :size => 12, :style => :bold, :align => :right
          pdf.move_down 1
        end
      end
    end
    pdf.default_leading 0
    pdf.bounding_box([150, 357], :width => 75) do
      tier_2_total_amount.each do |amounts|
        if amounts > 0
          pdf.text "#{number_to_currency(amounts, :precision => 0)}", :size => 12, :style => :bold, :align => :right
          pdf.move_down 1
        end
      end
    end
    pdf.bounding_box([150, 175], :width => 75) do
      tier_3_total_amount.each do |amounts|
        if amounts > 0
          pdf.text "#{number_to_currency(amounts, :precision => 0)}", :size => 12, :style => :bold, :align => :right
          pdf.move_down 1
        end
      end
      pdf.text "#{number_to_currency(gift_profile.remainder, :precision => 0)} or less", :size => 12, :style => :bold, :align => :center
    end
    # TIER 1 TOTALS
    pdf.text_box "#{number_to_currency(multiply(tier_1_gifts[0], tier_1_total_amount[0])) unless tier_1_gifts[0]==0}", :at => [255, 515], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(total(@running_total)) unless tier_1_gifts[0]==0}", :at => [375, 515], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(multiply(tier_1_gifts[1], tier_1_total_amount[1])) unless tier_1_gifts[1]==0}", :at => [255, 497], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(total(@running_total, @cumulative_total)) unless tier_1_gifts[1]==0}", :at => [375, 497], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(multiply(tier_1_gifts[2], tier_1_total_amount[2])) unless tier_1_gifts[2]==0}", :at => [255, 480], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(total(@running_total, @cumulative_total)) unless tier_1_gifts[2]==0}", :at => [375, 480], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(multiply(tier_1_gifts[3], tier_1_total_amount[3])) unless tier_1_gifts[3]==0}", :at => [255, 463], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(total(@running_total, @cumulative_total)) unless tier_1_gifts[3]==0}", :at => [375, 463], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(multiply(tier_1_gifts[4], tier_1_total_amount[4])) unless tier_1_gifts[4]==0}", :at => [255, 446], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(total(@running_total, @cumulative_total)) unless tier_1_gifts[4]==0}", :at => [375, 446], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(multiply(tier_1_gifts[5], tier_1_total_amount[5])) unless tier_1_gifts[5]==0}", :at => [255, 429], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(total(@running_total, @cumulative_total)) unless tier_1_gifts[5]==0}", :at => [375, 429], :align => :right, :width => 105
    #pdf.text_box "123456789123456", :at => [255, 425], :align => :right, :width => 105
    # COMMITMENTS SECTION
    pdf.bounding_box([80, 400], :width => 300) do
      pdf.text "#{tier_1_gifts.sum} Commitments = #{number_to_currency(commitments(tier_1_gifts, tier_1_total_amount))} or #{percent(commitments(tier_1_gifts, tier_1_total_amount))} of Goal", :size => 12, :align => :right
    end
    # TIER 2 Totals
    pdf.text_box "#{number_to_currency(multiply(tier_2_gifts[0], tier_2_total_amount[0])) unless tier_2_gifts[0]==0}", :at => [255, 357], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(total(@running_total, @cumulative_total)) unless tier_2_gifts[0]==0}", :at => [375, 357], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(multiply(tier_2_gifts[1], tier_2_total_amount[1])) unless tier_2_gifts[1]==0}", :at => [ 255, 342], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(total(@running_total, @cumulative_total)) unless tier_2_gifts[1]==0}", :at => [375, 342], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(multiply(tier_2_gifts[2], tier_2_total_amount[2])) unless tier_2_gifts[2]==0}", :at => [255, 327], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(total(@running_total, @cumulative_total)) unless tier_2_gifts[2]==0}", :at => [375, 327], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(multiply(tier_2_gifts[3], tier_2_total_amount[3])) unless tier_2_gifts[3]==0}", :at => [255, 312], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(total(@running_total, @cumulative_total)) unless tier_2_gifts[3]==0}", :at => [375, 312], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(multiply(tier_2_gifts[4], tier_2_total_amount[4])) unless tier_2_gifts[4]==0}", :at => [255, 297], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(total(@running_total, @cumulative_total)) unless tier_2_gifts[4]==0}", :at => [375, 297], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(multiply(tier_2_gifts[5], tier_2_total_amount[5])) unless tier_2_gifts[5]==0}", :at => [255, 282], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(total(@running_total, @cumulative_total)) unless tier_2_gifts[5]==0}", :at => [375, 282], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(multiply(tier_2_gifts[6], tier_2_total_amount[6])) unless tier_2_gifts[6]==0}", :at => [255, 267], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(total(@running_total, @cumulative_total)) unless tier_2_gifts[6]==0}", :at => [375, 267], :align => :right, :width => 105
    #COMMITMENTS SECTION
    pdf.bounding_box([80, 243], :width => 300) do
      pdf.text "#{tier_2_gifts.sum} Commitments = #{number_to_currency(commitments(tier_2_gifts, tier_2_total_amount))} or #{percent(commitments(tier_2_gifts, tier_2_total_amount))} of Goal", :size => 12, :align => :right
      pdf.move_down 5
      pdf.text "#{[tier_1_gifts.sum, tier_2_gifts.sum].sum} Commitments = #{number_to_currency(commitments(tier_1_gifts, tier_1_total_amount)+commitments(tier_2_gifts, tier_2_total_amount))} or #{percent(commitments(tier_1_gifts, tier_1_total_amount)+commitments(tier_2_gifts, tier_2_total_amount))} of Goal", :size => 12, :align => :right
    end
    # TIER 3 Totals
    pdf.text_box "#{number_to_currency(multiply(tier_3_gifts[0], tier_3_total_amount[0])) unless tier_3_gifts[0]==0}", :at => [255, 175], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(total_for_remainder(@running_total, @cumulative_total)) unless tier_3_gifts[0]==0}", :at => [375, 175], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(multiply(tier_3_gifts[1], tier_3_total_amount[1])) unless tier_3_gifts[1]==0}", :at => [255, 159], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(total(@running_total, @cumulative_total)) unless tier_3_gifts[1]==0}", :at => [375, 159], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(multiply(tier_3_gifts[2], tier_3_total_amount[2])) unless tier_3_gifts[2]==0}", :at => [255, 143], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(total(@running_total, @cumulative_total)) unless tier_3_gifts[2]==0}", :at => [375, 143], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(multiply(tier_3_gifts[3], tier_3_total_amount[3])) unless tier_3_gifts[3]==0}", :at => [255, 128], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(total(@running_total, @cumulative_total)) unless tier_3_gifts[3]==0}", :at => [375, 128], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(multiply(tier_3_gifts[4], tier_3_total_amount[4])) unless tier_3_gifts[4]==0}", :at => [255, 113], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(total(@running_total, @cumulative_total)) unless tier_3_gifts[4]==0}", :at => [375, 113], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(multiply(tier_3_gifts[5], tier_3_total_amount[5])) unless tier_3_gifts[5]==0}", :at => [255, 98], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(total(@running_total, @cumulative_total)) unless tier_3_gifts[5]==0}", :at => [375, 98], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(remainder_total_level)}", :at => [255, 82], :align => :right, :width => 105
    pdf.text_box "#{number_to_currency(remainder_cumulative_total)}", :at => [375, 82], :align => :right, :width => 105
    #COMMITMENTS SECTION
    pdf.bounding_box([80, 45], :width => 300) do
      pdf.text "#{tier_3_gifts.sum} Commitments = #{number_to_currency(tier_3_plus_remainder)} or #{percent(tier_3_plus_remainder)} of Goal", :size => 12, :align => :right
      pdf.move_down 5
      pdf.text "#{[tier_1_gifts.sum, tier_2_gifts.sum, tier_3_gifts.sum].sum} Commitments = #{number_to_currency(final_commitments)} or #{percent(final_commitments)} of Goal", :size => 12, :align => :right
    end
  end
  
  def add_enlistment_page1_data(pdf)
    pdf.default_leading 5
    # CONTACT ENLISTMENT
    size = 10
    pdf.bounding_box([157, 317], :width => 385) do
      pdf.text "#{campaign.training_sheet.man_contact}", :align => :center, :size => size
      pdf.move_down 6
      pdf.text "#{campaign.enlistment.contact_enlist} Assistants", :align => :center, :size => size
      pdf.move_down 6
      pdf.text "#{multiply(campaign.training_sheet.man_contact, campaign.enlistment.contact_enlist)}", :align => :center, :size => size
      pdf.move_down 6
      pdf.text "#{campaign.enlistment.campaign.enlistment.contact_each_enlist} Members", :align => :center, :size => size
      pdf.move_down 6
      pdf.text "#{contact_each_enlistment}", :align => :center, :size => size
      pdf.move_down 6
      pdf.text "#{sum(multiply(campaign.training_sheet.man_contact, campaign.enlistment.contact_enlist),(multiply((multiply(campaign.training_sheet.man_contact, campaign.enlistment.contact_enlist)), campaign.enlistment.contact_each_enlist)), campaign.training_sheet.man_contact)}", :align => :center, :size => size
    end
    # INFORMATION TEAM
    pdf.bounding_box([157, 151], :width => 385) do
      pdf.text "#{campaign.training_sheet.man_info}", :align => :center, :size => size
      pdf.move_down 6
      pdf.text "#{campaign.enlistment.info_enlist} Assistants", :align => :center, :size => size
      pdf.move_down 6
      pdf.text "#{multiply(campaign.training_sheet.man_info, campaign.enlistment.info_enlist)}", :align => :center, :size => size
      pdf.move_down 6
      pdf.text "#{sum((multiply(campaign.training_sheet.man_info, campaign.enlistment.info_enlist)), campaign.training_sheet.man_info)}", :align => :center, :size => size
    end
  end
  def add_enlistment_page2_data(pdf)
    size = 10
    # SPECIAL EVENT
    pdf.bounding_box([157, 622], :width => 385) do
      pdf.text "#{campaign.training_sheet.man_spc_event}", :align => :center, :size => size
      pdf.move_down 6
      pdf.text "#{campaign.enlistment.spc_event_enlist} Assistants", :align => :center, :size => size
      pdf.move_down 6
      pdf.text "#{multiply(campaign.training_sheet.man_spc_event, campaign.enlistment.spc_event_enlist)}", :align => :center, :size => size
      pdf.move_down 6
      pdf.text "#{sum((multiply(campaign.training_sheet.man_spc_event, campaign.enlistment.spc_event_enlist)), campaign.training_sheet.man_spc_event)}", :align => :center, :size => size
    end
    # CHILDREN's ACTIVITY TEAM
    pdf.bounding_box([157, 501], :width => 385) do
      pdf.text "#{campaign.training_sheet.man_childs_act}", :align => :center, :size => size
      pdf.move_down 6
      pdf.text "#{campaign.enlistment.childs_act_enlist} Assistants", :align => :center, :size => size
      pdf.move_down 6
      pdf.text "#{multiply(campaign.training_sheet.man_childs_act, campaign.enlistment.childs_act_enlist)}", :align => :center, :size => size
      pdf.move_down 6
      pdf.text "#{sum((multiply(campaign.training_sheet.man_childs_act, campaign.enlistment.childs_act_enlist)), campaign.training_sheet.man_childs_act)}", :align => :center, :size => size
    end
    # ADVANCE COMMITMENT TEAM
    pdf.bounding_box([157, 377], :width => 385) do
      pdf.text "#{campaign.training_sheet.man_ac}", :align => :center, :size => size
      pdf.move_down 6
      pdf.text "#{campaign.enlistment.ac_enlist} Assistants", :align => :center, :size => size
      pdf.move_down 6
      pdf.text "#{multiply(campaign.training_sheet.man_ac, campaign.enlistment.ac_enlist)}", :align => :center, :size => size
      pdf.move_down 15
      pdf.text "#{sum((multiply(campaign.training_sheet.man_ac, campaign.enlistment.ac_enlist)), campaign.training_sheet.man_ac)}", :align => :center, :size => size
    end
  end
  
  def add_giving_potential_data(pdf)
    pdf.draw_text "#{number_to_currency(gift_profile.goal, :precision => 0)}", :at => [110, 621], :size => 11, :style => :bold
    pdf.draw_text "#{number_to_currency(gift_profile.t1_gift_amount_1, :precision => 0)}", :at => [250, 532]
    pdf.draw_text "#{number_to_currency(gift_profile.t1_gift_amount_2, :precision => 0)}", :at => [250, 437]
    pdf.draw_text "#{number_to_currency(gift_profile.t1_gift_amount_3, :precision => 0)}", :at => [250, 320]
    pdf.draw_text "#{number_to_currency(gift_profile.t1_gift_amount_4, :precision => 0)}", :at => [250, 178]
    pdf.draw_text "#{user.name}.", :at => [22, 42], :size => 10
  end

end