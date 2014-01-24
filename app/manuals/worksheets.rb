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
    
    pdf.bounding_box([250, 225], :width => 270) do#was [250, 237]
      pdf.text "#{formatted_datetime_year(campaign.event.ac_mtg_3)}", :size => 10, :align => :left
      pdf.move_down 19
      pdf.text "#{formatted_datetime_year(campaign.event.ac_host_orient)}", :size => 10, :align => :left
      pdf.move_down 19
      pdf.text "#{formatted_date_range(begin_date: campaign.event.ac_res_calls_dates, end_date: campaign.event.ac_res_calls_end)}", :size => 10, :align => :left
      pdf.move_down 19
      pdf.text "#{formatted_datetime_year(campaign.event.ac_gather_1)}", :size => 10, :align => :left
      pdf.move_down 12
      pdf.text "#{formatted_datetime_year(campaign.event.ac_gather_2)}", :size => 10, :align => :left
      pdf.move_down 12
      pdf.text "#{formatted_datetime_year(campaign.event.ac_gather_3)}", :size => 10, :align => :left
      pdf.move_down 12
      pdf.text "#{formatted_datetime_year(campaign.event.ac_gather_4)}", :size => 10, :align => :left
    end
  end
  def add_AC2_data(pdf)
    self.get_campaign_title(pdf)
    
    pdf.draw_text "#{formatted_date(campaign.event.ac_res_calls_dates)}.", :at => [333, 533], :size => 10, :style => :bold
    pdf.draw_text "(from)", :at => [239, 418], :size => 9, :style => :italic
    pdf.draw_text "#{campaign.name}.", :at => [265, 428], :size => 9, :style => :bold_italic#was [265, 418]
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
    pdf.draw_text "#{campaign.name}.", :at => [230.5, 147.5], :size => 9, :style => :bold_italic#was [230.5, 138.5]
    pdf.draw_text "#{formatted_date_range(begin_date: campaign.event.information_act_dates, end_date: campaign.event.information_act_end)},", :at => [74, 125], :size => 9, :style => :bold
  end
  def add_CT5_data(pdf)
    self.get_campaign_title(pdf)
    
    pdf.draw_text "#{formatted_date_to_tomorrow(campaign.event.parish_wide_event_dates)}", :at => [293, 518], :size => 10, :style => :bold
    pdf.draw_text "#{formatted_date_range(begin_date: campaign.event.special_event_calls_dates, end_date: campaign.event.special_event_calls_end)}", :at => [245, 425.5], :size => 10, :style => :bold
    pdf.draw_text "#{campaign.name}.", :at => [230.5, 390.5], :size => 9, :style => :bold_italic#was [230.5, 381.5]
  end
  def add_CT6_data(pdf)
    self.get_campaign_title(pdf)
  end
  def add_CT7_data(pdf)
    self.get_campaign_title_no_loc(pdf)
    
    pdf.draw_text "#{formatted_date_range(begin_date: campaign.event.celebration_wknd_calls_dates, end_date: campaign.event.celebration_wknd_calls_end)}", :at => [247, 363], :size => 10, :style => :bold
    pdf.draw_text "#{campaign.name}.", :at => [216, 290.5], :size => 9, :style => :bold_italic#was [216, 281.5]
    pdf.draw_text "#{formatted_date_to_tomorrow(campaign.event.celebration_mass_dates)}.", :at => [313.6, 210], :size => 9, :style => :bold_italic
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