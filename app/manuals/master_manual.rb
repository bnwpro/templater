class MasterManual < Manual
  
  attr_accessor :campaign
  
  def create_master_program_manual(options = {})
    campaign_dir = options[:campaign_dir]
    manual_campaign_dir = options[:manual_campaign_dir]
    self.campaign = options[:campaign]
    appendices_dir = "pdfs/templates/appendices"
    
    Prawn::Document.generate("#{manual_campaign_dir}/pr_Program_Manager's_Manual.pdf", {:page_size => 'LETTER', :skip_page_creation => true}) do |pdf|
      pdf.start_new_page(:template => "pdfs/templates/intro_pages/1_cover.pdf")
      pdf.fill_color "000000"
      pdf.bounding_box([100, 600], :width => 375) do
        pdf.text "#{campaign.name}", :size => 32, :style => :bold, :align => :center
        pdf.move_down 40
        pdf.text "#{campaign.city}, #{campaign.state}", :size => 24, :style => :normal, :align => :center
        pdf.move_down 40
        pdf.text "Master Program Manual", :size => 32, :style => :bold, :align => :center
      end
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/common_pages.pdf")
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/common_pages_enlist.pdf")
      # "Advance Commitment Guide"
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/ac_resp.pdf")
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/ac.pdf")
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/giving_potential.pdf")
      # "Campaign Administrator Guide"
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/cadmin_resp.pdf")
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/cadmin_to_ws1.pdf")
      Worksheets.new.add_cadmin_ws1_data(pdf, campaign)
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/cadmin_ws1_to_ws2.pdf")
      Worksheets.new.add_cadmin_ws2_data(pdf, campaign)
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/cadmin_ws3.pdf")
      Worksheets.new.add_cadmin_ws3_data(pdf, campaign)
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/cadmin_ws3_to_ws4.pdf")
      Worksheets.new.add_cadmin_ws4_data(pdf, campaign)
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/cadmin_ws5.pdf")
      Worksheets.new.add_cadmin_ws5_data(pdf, campaign)
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/cadmin_to_end.pdf")
    # "Campaign Chair Guide"
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/chair_resp.pdf")
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/chair.pdf")
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/giving_potential.pdf")
    # "Children Activity Leader Guide"
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/childs_act_resp.pdf")
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/childs_act.pdf")
    # "Contact Leader Guide"
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/contact_resp.pdf")
    # "Event Leader Guide"
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/event_resp.pdf")
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/event.pdf")
    # "Follow Up Leader Guide"
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/follow_resp.pdf")
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/follow.pdf")
    # "Information Leader Guide"
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/info_resp.pdf")
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/info.pdf")
    # "Involvement Leader Guide"
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/involve_resp.pdf")
    # "Pacesetter Leader Guide"
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/pacesetter_resp.pdf")
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/pacesetter.pdf")
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/giving_potential.pdf")
    # "Pastor Guide"
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/pastor_resp.pdf")
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/pastor.pdf")
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/giving_potential.pdf")
    # "Prayer Leader Guide"
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/prayer_resp.pdf")
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/prayer.pdf")
    # "Print Leader Guide"
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/print_resp.pdf")
    # "Visual Communications Leader Guide"
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/visual_resp.pdf")
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/visual.pdf")
    # "Youth Leader Guide"
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/youth_resp.pdf")
      PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/youth.pdf")
      
    # Worksheets
    #  PdfMerger.get_template_to_merge(pdf: pdf, path: "#{manual_campaign_dir}/AC1-en.pdf")
    #  PdfMerger.get_template_to_merge(pdf: pdf, path: "#{manual_campaign_dir}/AC2-en.pdf")
    #  PdfMerger.get_template_to_merge(pdf: pdf, path: "#{manual_campaign_dir}/AC3-en.pdf")
    #  PdfMerger.get_template_to_merge(pdf: pdf, path: "#{manual_campaign_dir}/CT1-en.pdf")
    #  PdfMerger.get_template_to_merge(pdf: pdf, path: "#{manual_campaign_dir}/CT2-en.pdf")
    #  PdfMerger.get_template_to_merge(pdf: pdf, path: "#{manual_campaign_dir}/CT3-en.pdf")
    #  PdfMerger.get_template_to_merge(pdf: pdf, path: "#{manual_campaign_dir}/CT4-en.pdf")
    #  PdfMerger.get_template_to_merge(pdf: pdf, path: "#{manual_campaign_dir}/CT5-en.pdf")
    #  PdfMerger.get_template_to_merge(pdf: pdf, path: "#{manual_campaign_dir}/CT6-en.pdf")
    #  PdfMerger.get_template_to_merge(pdf: pdf, path: "#{manual_campaign_dir}/CT7-en.pdf")
    #  PdfMerger.get_template_to_merge(pdf: pdf, path: "#{manual_campaign_dir}/IN1-en.pdf")
    #  PdfMerger.get_template_to_merge(pdf: pdf, path: "#{manual_campaign_dir}/IN2-en.pdf")
    end
  end
end