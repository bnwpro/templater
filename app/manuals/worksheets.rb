class Worksheets < Manual
  
  attr_accessor :campaign
  
  def create_worksheets(options = {})
    worksheets = options[:worksheets]
    manual_campaign_docs_dir = options[:manual_campaign_docs_dir]
    self.campaign = options[:campaign]
    
    worksheets.each do |path_to_doc|
      doc_name_stripped = path_to_doc.split('/')[-1]
      Prawn::Document.generate("#{manual_campaign_docs_dir}/#{doc_name_stripped}", {:page_size => 'LETTER', :skip_page_creation => true}) do |pdf|
        PdfMerger.get_template_to_merge(pdf: pdf, path: path_to_doc)
        case doc_name_stripped
        when "AC1-en.pdf"
          self.add_AC1_data(pdf)
        when "AC2-en.pdf"
          self.add_AC2_data(pdf)
        when "AC3-en.pdf"
          self.add_AC3_data(pdf)
        when "CT1-en.pdf"
          self.add_CT1_data(pdf)
        when "CT2-en.pdf"
          self.add_CT2_data(pdf)
        when "CT3-en.pdf"
          self.add_CT3_data(pdf)
        when "CT4-en.pdf"
          self.add_CT4_data(pdf)
        when "CT5-en.pdf"
          self.add_CT5_data(pdf)
        when "CT6-en.pdf"
          self.add_CT6_data(pdf)
        when "CT7-en.pdf"
          self.add_CT7_data(pdf)
        when "IN1-en.pdf"
          self.add_IN1_data(pdf)
        when "IN2-en.pdf"
          self.add_IN2_data(pdf)
        end
      end
    end
  end
  
  def add_AC1_data(pdf)
    default_leading 5
    get_campaign_title(pdf)
    
    date_1 = "#{formatted_datetime_year(campaign.event.ac_mtg_3)}"
    date_2 = "#{formatted_datetime_year(campaign.event.ac_host_orient)}"
    date_3 = "#{formatted_date_range(begin_date: campaign.event.ac_res_calls_dates, end_date: campaign.event.ac_res_calls_end)}"
    date_4 = "#{formatted_datetime_year(campaign.event.ac_gather_1)}"
    date_5 = "#{formatted_datetime_year(campaign.event.ac_gather_2)}"
    date_6 = "#{formatted_datetime_year(campaign.event.ac_gather_3)}"
    date_7 = "#{formatted_datetime_year(campaign.event.ac_gather_4)}"
    
    size = 10
    unless date_1.empty?
      pdf.draw_text "TEAM TRAINING:", :at => [150, 225], :size => size, :style => :bold
      pdf.draw_text date_1, :at => [270, 225], :size => size
    end
    unless date_2.empty?
      pdf.draw_text "HOST ORIENTATION:", :at => [150, 190], :size => size, :style => :bold
      pdf.draw_text date_2, :at => [270, 190], :size => size
    end
    unless date_3.length <= 1
      pdf.draw_text "RESERVATION CALLS:", :at => [150, 155], :size => size, :style => :bold
      pdf.draw_text date_3, :at => [270, 155], :size => size
    end
    unless date_4.empty?
      pdf.draw_text "GATHERING(S):", :at => [150, 120], :size => size, :style => :bold
      pdf.draw_text date_4, :at => [270, 120], :size => size
      pdf.draw_text date_5, :at => [270, 100], :size => size
      pdf.draw_text date_6, :at => [270, 80], :size => size
      pdf.draw_text date_7, :at => [270, 60], :size => size
    end
  end
  def add_AC2_data(pdf)
    self.get_campaign_title(pdf)
    
    pdf.draw_text "#{formatted_date(campaign.event.ac_res_calls_dates)}.", :at => [333, 533], :size => 10, :style => :bold
    pdf.text_box "Hello, this is (your name) from #{campaign.name}. I am working in the leadership of our ____________ program. Recently, you received an invitation from our pastor to a special gathering on ______________. I have been asked to call you to receive your reservation. Our pastor and other parish leaders will share our parish's plans for the future. 
    May I confirm your attendance?", :at => [75, 430], :width => 400, :style => :italic, :size => 9, :leading => 2
    #pdf.draw_text "(from)", :at => [239, 418], :size => 9, :style => :italic
    #pdf.draw_text "#{campaign.name}.", :at => [265, 428], :size => 9, :style => :bold_italic#was [265, 418]
    pdf.draw_text "#{formatted_date_to_tomorrow(campaign.event.parish_wide_event_dates)}.", :at => [247, 114], :size => 11, :style => :bold
  end
  def add_AC3_data(pdf)
    self.get_campaign_title_no_loc(pdf)
  end
  def add_CT1_data(pdf)
    self.get_campaign_title(pdf)
    
    pdf.draw_text "#{formatted_datetime_year(campaign.event.contact_team_asst_trng_1)}", :at => [100, 107], :size => 10
    pdf.draw_text "#{formatted_datetime_year(campaign.event.contact_team_trng_1)}", :at => [315, 107], :size => 10
    pdf.draw_text "#{formatted_date_range(begin_date: campaign.event.info_calls_dates, end_date: campaign.event.info_calls_end)}", :at => [285, 87], :size => 10
    pdf.draw_text "#{formatted_date_range(begin_date: campaign.event.special_event_calls_dates, end_date: campaign.event.special_event_calls_end)}", :at => [285, 72], :size => 10
    pdf.draw_text "#{formatted_date_range(begin_date: campaign.event.celebration_wknd_calls_dates, end_date: campaign.event.celebration_wknd_calls_end)}", :at => [272, 56], :size => 10
  end
  def add_CT2_data(pdf)
    self.get_campaign_title(pdf)
    
    pdf.text_box "#{formatted_datetime_year(campaign.event.contact_team_asst_trng_1)}", :at => [135, 572], :width => 270, :size => 12, :style => :bold, :align => :center
    pdf.draw_text "#{campaign.enlistment.contact_each_enlist}", :at => [281, 500], :size => 11, :style => :bold#was [282, 500]
    pdf.draw_text "#{formatted_datetime_year(campaign.event.contact_team_trng_1)}", :at => [285, 361.5], :size => 11
    pdf.bounding_box([275, 298.5], :width => 270) do
      pdf.text "#{formatted_date_range(begin_date: campaign.event.info_calls_dates, end_date: campaign.event.info_calls_end)}", :size => 11, :align => :left
      pdf.move_down 4
      pdf.text "#{formatted_date_range(begin_date: campaign.event.special_event_calls_dates, end_date: campaign.event.special_event_calls_end)}", :size => 11, :align => :left
      pdf.move_down 4
      pdf.text "#{formatted_date_range(begin_date: campaign.event.celebration_wknd_calls_dates, end_date: campaign.event.celebration_wknd_calls_end)}", :size => 11, :align => :left
    end
  end
  def add_CT3_data(pdf)
    self.get_campaign_title(pdf)
  end
  def add_CT4_data(pdf)
    self.get_campaign_title(pdf)
    
    pdf.draw_text "#{formatted_date_range(begin_date: campaign.event.info_calls_dates, end_date: campaign.event.info_calls_end)}", :at => [210, 301.5], :size => 10, :style => :bold
    pdf.text_box "\"Hello, this is (your name) calling from #{campaign.name}. Is this the (household name) residence? 
    On #{formatted_date_range(begin_date: campaign.event.information_act_dates, end_date: campaign.event.information_act_end)}, our parish is distributing an Information Packet to each household to share information about what our parish is doing. To save postage, we are asking each family to pick up a packet when they attend Mass. I am calling to encourage you to attend Mass and pick up your packet. I think you will find the information of great interest. I would also like to take this opportunity to be sure the information we have about your family is correct... Finally, is there any way our parish can serve you better and support you in our prayers?\" (Consultant may give additional instructions.)", :at => [65, 145], :width => 430, :style => :italic, :size => 9, :leading => 2.5
    #pdf.draw_text "#{campaign.name}.", :at => [230.5, 147.5], :size => 9, :style => :bold_italic#was [230.5, 138.5]
    #pdf.draw_text "#{formatted_date_range(begin_date: campaign.event.information_act_dates, end_date: campaign.event.information_act_end)},", :at => [74, 125], :size => 9, :style => :bold
  end
  def add_CT5_data(pdf)
    self.get_campaign_title(pdf)
    
    pdf.draw_text "#{formatted_date_to_tomorrow(campaign.event.parish_wide_event_dates)}", :at => [293, 518], :size => 10, :style => :bold
    pdf.draw_text "#{formatted_date_range(begin_date: campaign.event.special_event_calls_dates, end_date: campaign.event.special_event_calls_end)}", :at => [245, 425.5], :size => 10, :style => :bold
    pdf.text_box "\"Hello, this is (your name) calling for #{campaign.name}. Is this the (household name) residence? A few days ago, you should have received an invitation to attend the Parish-Wide Event Weekend for our __________________ campaign. This will be a great time in the life of the parish. A nursery and activities for children will be provided.
    May I confirm your (and your family's) attendance?\" (Consultant may give additional instructions.)", :at => [75, 385], :width => 400, :style => :italic, :size => 9, :leading => 2
    #pdf.draw_text "#{campaign.name}.", :at => [230.5, 390.5], :size => 9, :style => :bold_italic#was [230.5, 381.5]
  end
  def add_CT6_data(pdf)
    self.get_campaign_title(pdf)
  end
  def add_CT7_data(pdf)
    self.get_campaign_title_no_loc(pdf)
    
    pdf.draw_text "#{formatted_date_range(begin_date: campaign.event.celebration_wknd_calls_dates, end_date: campaign.event.celebration_wknd_calls_end)}", :at => [247, 363], :size => 10, :style => :bold
    pdf.formatted_text_box [{:text => "\"Hello, this is (your name) calling for #{campaign.name}. Is this the (household name) residence? We want everyone in our parish family to be a part of _________________. A few days ago, you may have received a letter with a Commitment Card. You may have already returned your Commitment Card.\"", :styles => [:italic]},
      {:text => "\n(If the response is \"yes\", thank them for their participation and positive response.)", :styles => [:bold]},
      {:text => "\n\"If you are planning to participate, please return your card by #{formatted_date_to_tomorrow(campaign.event.celebration_mass_dates)}.\"", :styles => [:italic]},{:text => "\n(Consultant may give additional instructions.)"}], :at => [75, 285], :width => 400, :size => 9, :leading => 2
    #pdf.draw_text "#{campaign.name}.", :at => [216, 290.5], :size => 9, :style => :bold_italic#was [216, 281.5]
    #pdf.draw_text "#{formatted_date_to_tomorrow(campaign.event.celebration_mass_dates)}.", :at => [313.6, 210], :size => 9, :style => :bold_italic
  end
  def add_IN1_data(pdf)
    self.get_campaign_title(pdf)
    
    pdf.text_box "#{formatted_datetime_year(campaign.event.info_team_trng_1)}", :at => [137, 110.5], :width => 270, :size => 11, :style => :bold, :align => :center
    pdf.text_box "#{formatted_date_range(begin_date: campaign.event.information_act_dates, end_date: campaign.event.information_act_end)}", :at => [137, 63], :width => 270, :size => 11, :style => :bold, :align => :center
  end
  def add_IN2_data(pdf)
    self.get_campaign_title_no_loc(pdf)
  end
  
  def get_campaign_title(pdf)
    pdf.bounding_box([35, 703], :width => 470) do
      pdf.text "#{campaign.name}", :size => 18, :style => :bold, :align => :center
      pdf.move_down 1
      pdf.text "#{campaign.city}, #{campaign.state}", :size => 12, :style => :bold, :align => :center
    end
  end
  def get_campaign_title_no_loc(pdf)
    pdf.bounding_box([35, 703], :width => 470) do
      pdf.text "#{campaign.name}", :size => 18, :style => :bold, :align => :center
    end
  end
  
  #Campaign Admin Worksheet Data for Appendix
  def add_cadmin_ws1_data(pdf, campaign)
    pdf.draw_text "#{campaign.training_sheet.man_contact}", :at => [94.5, 552.5], :size => 11, :style => :bold
    pdf.draw_text "#{multiply(campaign.training_sheet.man_contact, campaign.enlistment.contact_enlist)}", :at => [94.5, 462.5], :size => 11, :style => :bold
    pdf.draw_text "#{campaign.enlistment.contact_each_enlist}", :at => [71.5, 418.5], :size => 11, :style => :bold
    pdf.draw_text "#{formatted_datetime_year(campaign.event.contact_team_asst_trng_1)}.", :at => [36.5, 272], :size => 11, :style => :bold
  end
  def add_cadmin_ws2_data(pdf, campaign)
    pdf.draw_text "#{sum((multiply((multiply(campaign.training_sheet.man_contact, campaign.enlistment.contact_enlist)), campaign.enlistment.contact_each_enlist)), campaign.training_sheet.man_contact)}", :at => [81, 629], :size => 11, :style => :bold
    pdf.draw_text "#{formatted_datetime_year(campaign.event.contact_team_trng_1)}", :at => [36.5, 363.5], :size => 11, :style => :bold
  end
  def add_cadmin_ws3_data(pdf, campaign)
    pdf.draw_text "#{sum((multiply(campaign.training_sheet.man_info, campaign.enlistment.info_enlist)), campaign.training_sheet.man_info)}", :at => [91.5, 611], :size => 11, :style => :bold
    pdf.draw_text "#{formatted_datetime_year(campaign.event.info_team_trng_1)}", :at => [36.5, 523.5], :size => 11, :style => :bold
  end
  def add_cadmin_ws4_data(pdf, campaign)
    pdf.draw_text "#{campaign.training_sheet.man_ac}", :at => [91.5, 563], :size => 11, :style => :bold
    pdf.draw_text "#{campaign.enlistment.ac_enlist}", :at => [72, 460.5], :size => 11, :style => :bold
    pdf.draw_text "#{formatted_datetime_year(campaign.event.ac_mtg_2)}", :at => [51, 400], :size => 11, :style => :bold
  end
  def add_cadmin_ws5_data(pdf, campaign)
    ac_total = "#{sum((multiply(campaign.training_sheet.man_ac, campaign.enlistment.ac_enlist)), campaign.training_sheet.man_ac)}"
    pdf.draw_text ac_total, :at => [152.5, 482], :size => 11, :style => :bold
    pdf.draw_text ac_total, :at => [177.5, 394], :size => 11
    pdf.draw_text ac_total, :at => [152.5, 351.5], :size => 11, :style => :bold
    pdf.draw_text "#{formatted_datetime_year(campaign.event.ac_host_orient)}.", :at => [183, 118], :size => 11, :style => :bold
  end
end