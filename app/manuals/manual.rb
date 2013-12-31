class Manual < Prawn::Document
  
  include ActionView::Helpers::NumberHelper
  include ApplicationHelper
  include GiftProfilesHelper
  
  attr_accessor :user, :campaign, :gift_profile
  attr_accessor :tier_1_gifts, :tier_2_gifts, :tier_3_gifts, :tier_1_total_amount, :tier_2_total_amount, :tier_3_total_amount
  
  # ENTRY POINT: renders and custom Prawn file to be merged at any point with master.pdf  
  def to_pdf(user, campaign)
    self.user = user
    self.campaign = campaign
    self.gift_profile = campaign.gift_profile
    self.tier_1_gifts = [gift_profile.t1_gifts_1, gift_profile.t1_gifts_2, gift_profile.t1_gifts_3, gift_profile.t1_gifts_4, gift_profile.t1_gifts_5, gift_profile.t1_gifts_6]
    self.tier_2_gifts = [gift_profile.t2_gifts_1, gift_profile.t2_gifts_2, gift_profile.t2_gifts_3, gift_profile.t2_gifts_4, gift_profile.t2_gifts_5, gift_profile.t2_gifts_6, gift_profile.t2_gifts_7]
    self.tier_3_gifts = [gift_profile.t3_gifts_1, gift_profile.t3_gifts_2, gift_profile.t3_gifts_3, gift_profile.t3_gifts_4, gift_profile.t3_gifts_5, gift_profile.t3_gifts_6]
    self.tier_1_total_amount = [gift_profile.t1_gift_amount_1, gift_profile.t1_gift_amount_2, gift_profile.t1_gift_amount_3, gift_profile.t1_gift_amount_4, gift_profile.t1_gift_amount_5, gift_profile.t1_gift_amount_6]
    self.tier_2_total_amount = [gift_profile.t2_gift_amount_1, gift_profile.t2_gift_amount_2, gift_profile.t2_gift_amount_3, gift_profile.t2_gift_amount_4, gift_profile.t2_gift_amount_5, gift_profile.t2_gift_amount_6, gift_profile.t2_gift_amount_7]
    self.tier_3_total_amount = [gift_profile.t3_gift_amount_1, gift_profile.t3_gift_amount_2, gift_profile.t3_gift_amount_3, gift_profile.t3_gift_amount_4, gift_profile.t3_gift_amount_5, gift_profile.t3_gift_amount_6]
    manual_titles_en = Document.manual_titles_en
    manual_common_pages_en = ["pdfs/templates/intro_pages/1_cover.pdf", "pdfs/templates/intro_pages/2_index_contact.pdf",
      "pdfs/templates/intro_pages/3_upto_gift_profile.pdf", "pdfs/templates/intro_pages/4_gift_profile_chart.pdf",
      "pdfs/templates/intro_pages/5_upto_enlist_1.pdf", "pdfs/templates/intro_pages/6_enlist_2.pdf",
      "pdfs/templates/intro_pages/7_upto_involvement.pdf"]
    worksheets_en = ["pdfs/templates/addendums/AC1-en.pdf", "pdfs/templates/addendums/AC2-en.pdf", "pdfs/templates/addendums/AC3-en.pdf",
      "pdfs/templates/addendums/CT1-en.pdf", "pdfs/templates/addendums/CT2-en.pdf", "pdfs/templates/addendums/CT3-en.pdf", "pdfs/templates/addendums/CT4-en.pdf",
      "pdfs/templates/addendums/CT5-en.pdf", "pdfs/templates/addendums/CT6-en.pdf", "pdfs/templates/addendums/CT7-en.pdf",
      "pdfs/templates/addendums/IN1-en.pdf", "pdfs/templates/addendums/IN2-en.pdf"]
      
    #begin  
      save_dir = "pdfs/campaign_docs/#{campaign.id}"
      Dir.mkdir(save_dir) unless File.exists?(save_dir)
      #move_files_to_public(save_dir)
      #return
      #create_print_manifest(save_dir)
      if File.exist?("#{save_dir}/block_calendar.pdf")
        #return
        create_common_pages(manual_common_pages_en, save_dir)
        #create_cover_page  #TEMP
        create_cover_pages(manual_titles_en, save_dir)
    
        create_worksheets(worksheets_en, save_dir)
        # TEMP
        #create_single_addendum(addendums_en)
        create_master_program_manual(save_dir)
        
        create_print_manifest(save_dir)
      end
      #rescue
      #raise "Block Calendar has not been uploaded.  Please upload your Block Calendar to continue."
      #return
      #end
      move_files_to_public(save_dir)
  end
  
  private
  def move_files_to_public(save_dir)
    origin = save_dir+'/manuals'
    destination = "public/pdfs/campaign_docs/#{campaign.name}/manuals"
    #Dir.mkdir(File.join('public', 'pdfs', 'campaign_docs', "#{campaign.id}", 'manuals')) unless File.exists?(destination)
    Dir.mkdir('public/pdfs') unless File.exists?('public/pdfs')
    Dir.mkdir('public/pdfs/campaign_docs') unless File.exists?('public/pdfs/campaign_docs')
    Dir.mkdir("public/pdfs/campaign_docs/#{campaign.name}") unless File.exists?("public/pdfs/campaign_docs/#{campaign.name}")
    Dir.mkdir("public/pdfs/campaign_docs/#{campaign.name}/manuals") unless File.exists?("public/pdfs/campaign_docs/#{campaign.name}/manuals")
    Dir.glob(File.join(origin, '*')).each do |file|
      #if File.exists? File.join(destination, File.basename(file))
       # File.delete file, File.join(destination, File.basename(file))
      #end
      FileUtils.mv file, File.join(destination, File.basename(file))
    end
  end
  # Print Manifest
  def create_print_manifest(save_dir)
    manual_save_dir = save_dir+'/manuals'
    data = [["Count", "Filename"], ["#{campaign.training_sheet.man_ac}", "Advance Commitment Leader Guide.pdf"],
    ["#{campaign.training_sheet.man_camp_admin}", "Campaign Administrator Guide.pdf"],
    ["#{campaign.training_sheet.man_camp_chair}", "Campaign Chair Guide.pdf"],
    ["#{campaign.training_sheet.man_childs_act}", "Children's Activity Leader Guide.pdf"],
    ["#{campaign.training_sheet.man_contact}", "Contact Leader Guide.pdf"],
    ["#{campaign.training_sheet.man_spc_event}", "Event Leader Guide.pdf"],
    ["#{campaign.training_sheet.man_follow_up}", "Follow Up Leader Guide.pdf"],
    ["#{campaign.training_sheet.man_info}", "Information Leader Guide.pdf"],
    ["#{campaign.training_sheet.man_invlvm}", "Involvement Leader Guide.pdf"],
    ["#{campaign.training_sheet.man_pace_gifts}", "Pacesetter Leader Guide.pdf"],
    ["#{campaign.training_sheet.man_pastor}", "Pastor Guide.pdf"],
    ["#{campaign.training_sheet.man_prayer}", "Prayer Leader Guide.pdf"],
    ["#{campaign.training_sheet.man_print_comm}", "Print Leader Guide.pdf"],
    ["#{campaign.training_sheet.man_vis_comm}", "Visual Communications Leader Guide.pdf"],
    ["#{campaign.training_sheet.man_youth}", "Youth Leader Guide.pdf"],
    ["1", "Program Manager's Manual.pdf"],
    ["#{campaign.training_sheet.ts_ac1}", "AC1.pdf - Salmon color paper"],
    ["#{campaign.training_sheet.ts_ac2}", "AC2.pdf - Salmon color paper"],
    ["#{campaign.training_sheet.ts_ac3}", "AC3.pdf - Salmon color paper"],
    ["#{campaign.training_sheet.ts_ct1}", "CT1.pdf - Light Green color paper"],
    ["#{campaign.training_sheet.ts_ct2}", "CT2.pdf - Light Green color paper"],
    ["#{campaign.training_sheet.ts_ct3}", "CT3.pdf - White paper"],
    ["#{campaign.training_sheet.ts_ct4}", "CT4.pdf - Light Green color paper"],
    ["#{campaign.training_sheet.ts_ct5}", "CT5.pdf - Pink color paper"],
    ["#{campaign.training_sheet.ts_ct6}", "CT6.pdf - Pink color paper"],
    ["#{campaign.training_sheet.ts_ct7}", "CT7.pdf - Light Blue color paper"],
    ["#{campaign.training_sheet.ts_it1}", "IN1.pdf - Yellow (canary) color paper"],
    ["#{campaign.training_sheet.ts_it2}", "IN2.pdf - Yellow (canary) color paper"]]
    Prawn::Document.generate("#{manual_save_dir}/PrintReport.pdf", {:page_size => 'A4', :skip_page_creation => true}) do |pdf|
      pdf.start_new_page
      pdf.draw_text "Print Report for: #{campaign.name}, #{campaign.city}", :at => [25, 780]
      pdf.draw_text "Created: #{formatted_datetime_year(Time.now)}", :at => [300, 780]
      pdf.move_down 10
      pdf.table(data, :header => true)
    end
  end
  
  # Program Manager's Manual
  def create_master_program_manual(save_dir)
    appendices_dir = "pdfs/templates/appendices"
    manual_save_dir = save_dir+'/manuals'
    Prawn::Document.generate("#{manual_save_dir}/Program Manager's Manual.pdf", {:page_size => 'A4', :skip_page_creation => true}) do |pdf|
      pdf.start_new_page(:template => "pdfs/templates/intro_pages/1_cover.pdf")
      pdf.fill_color "000000"
      pdf.bounding_box([100, 600], :width => 375) do
        pdf.text "#{campaign.name}", :size => 32, :style => :bold, :align => :center
        pdf.move_down 40
        pdf.text "#{campaign.city}, #{campaign.state}", :size => 24, :style => :normal, :align => :center
        pdf.move_down 40
        pdf.text "Master Program Manual", :size => 32, :style => :bold, :align => :center
      end
      get_template_to_merge(pdf, "#{save_dir}/common_pages.pdf")
      # "Advance Commitment Guide"
      get_template_to_merge(pdf, "#{save_dir}/resp/ac_resp.pdf")
      get_template_to_merge(pdf, "#{appendices_dir}/ac.pdf")
      get_template_to_merge(pdf, "#{appendices_dir}/common/giving_potential.pdf")
      add_giving_potential_data(pdf)
      # "Campaign Administrator Guide"
      get_template_to_merge(pdf, "#{save_dir}/resp/cadmin_resp.pdf")
      get_template_to_merge(pdf, "#{appendices_dir}/cadmin_to_ws1.pdf")
      add_cadmin_ws1_data(pdf)
      get_template_to_merge(pdf, "#{appendices_dir}/cadmin_ws1_to_ws2.pdf")
      add_cadmin_ws2_data(pdf)
      get_template_to_merge(pdf, "#{appendices_dir}/cadmin_ws3.pdf")
      add_cadmin_ws3_data(pdf)
      get_template_to_merge(pdf, "#{appendices_dir}/cadmin_ws3_to_ws4.pdf")
      add_cadmin_ws4_data(pdf)
      get_template_to_merge(pdf, "#{appendices_dir}/cadmin_ws5.pdf")
      add_cadmin_ws5_data(pdf)
      get_template_to_merge(pdf, "#{appendices_dir}/cadmin_to_end.pdf")
    # "Campaign Chair Guide"
      get_template_to_merge(pdf, "#{save_dir}/resp/chair_resp.pdf")
      get_template_to_merge(pdf, "#{appendices_dir}/chair.pdf")
      get_template_to_merge(pdf, "#{appendices_dir}/common/giving_potential.pdf")
      add_giving_potential_data(pdf)
    # "Children Activity Leader Guide"
      get_template_to_merge(pdf, "#{save_dir}/resp/childs_act_resp.pdf")
      get_template_to_merge(pdf, "#{appendices_dir}/childs_act.pdf")
    # "Contact Leader Guide"
      get_template_to_merge(pdf, "#{save_dir}/resp/contact_resp.pdf")
    # "Event Leader Guide"
      get_template_to_merge(pdf, "#{save_dir}/resp/event_resp.pdf")
      get_template_to_merge(pdf, "#{appendices_dir}/event.pdf")
    # "Follow Up Leader Guide"
      get_template_to_merge(pdf, "#{save_dir}/resp/follow_resp.pdf")
      get_template_to_merge(pdf, "#{appendices_dir}/follow.pdf")
    # "Information Leader Guide"
      get_template_to_merge(pdf, "#{save_dir}/resp/info_resp.pdf")
      get_template_to_merge(pdf, "#{appendices_dir}/info.pdf")
    # "Involvement Leader Guide"
      get_template_to_merge(pdf, "#{save_dir}/resp/involve_resp.pdf")
    # "Pacesetter Leader Guide"
      get_template_to_merge(pdf, "#{save_dir}/resp/pacesetter_resp.pdf")
      get_template_to_merge(pdf, "#{appendices_dir}/pacesetter.pdf")
      get_template_to_merge(pdf, "#{appendices_dir}/common/giving_potential.pdf")
      add_giving_potential_data(pdf)
    # "Pastor Guide"
      get_template_to_merge(pdf, "#{save_dir}/resp/pastor_resp.pdf")
      get_template_to_merge(pdf, "#{appendices_dir}/pastor.pdf")
      get_template_to_merge(pdf, "#{appendices_dir}/common/giving_potential.pdf")
      add_giving_potential_data(pdf)
    # "Prayer Leader Guide"
      get_template_to_merge(pdf, "#{save_dir}/resp/prayer_resp.pdf")
      get_template_to_merge(pdf, "#{appendices_dir}/prayer.pdf")
    # "Print Leader Guide"
      get_template_to_merge(pdf, "#{save_dir}/resp/print_resp.pdf")
    # "Visual Communications Leader Guide"
      get_template_to_merge(pdf, "#{save_dir}/resp/visual_resp.pdf")
      get_template_to_merge(pdf, "#{appendices_dir}/visual.pdf")
    # "Youth Leader Guide"
      get_template_to_merge(pdf, "#{save_dir}/resp/youth_resp.pdf")
      get_template_to_merge(pdf, "#{appendices_dir}/youth.pdf")
      
    # Worksheets
      get_template_to_merge(pdf, "#{manual_save_dir}/AC1-en.pdf")
      get_template_to_merge(pdf, "#{manual_save_dir}/AC2-en.pdf")
      get_template_to_merge(pdf, "#{manual_save_dir}/AC3-en.pdf")
      get_template_to_merge(pdf, "#{manual_save_dir}/CT1-en.pdf")
      get_template_to_merge(pdf, "#{manual_save_dir}/CT2-en.pdf")
      get_template_to_merge(pdf, "#{manual_save_dir}/CT3-en.pdf")
      get_template_to_merge(pdf, "#{manual_save_dir}/CT4-en.pdf")
      get_template_to_merge(pdf, "#{manual_save_dir}/CT5-en.pdf")
      get_template_to_merge(pdf, "#{manual_save_dir}/CT6-en.pdf")
      get_template_to_merge(pdf, "#{manual_save_dir}/CT7-en.pdf")
      get_template_to_merge(pdf, "#{manual_save_dir}/IN1-en.pdf")
      get_template_to_merge(pdf, "#{manual_save_dir}/IN2-en.pdf")
    end
    
    FileUtils.rm_rf(save_dir+'/resp')
  end
  
  def create_cover_pages(manual_titles, save_dir)
    #manual_titles = ["Campaign Administrator Guide"]
    #save_dir = "pdfs/campaign_docs/#{campaign.id}/manuals"
    appendices_dir = "pdfs/templates/appendices"
    manual_save_dir = save_dir+'/manuals'
    Dir.mkdir(manual_save_dir) unless File.exists?(manual_save_dir)
    resp = Document.resp_doc
    name = resp.first
    manual_titles.each do |cover_page|
      Prawn::Document.generate("#{manual_save_dir}/#{cover_page}.pdf", {:page_size => 'A4', :skip_page_creation => true}) do |pdf|
        pdf.start_new_page(:template => "pdfs/templates/intro_pages/1_cover.pdf")
        pdf.fill_color "000000"
        pdf.bounding_box([100, 600], :width => 375) do
          pdf.text "#{campaign.name}", :size => 32, :style => :bold, :align => :center
          pdf.move_down 40
          pdf.text "#{campaign.city}, #{campaign.state}", :size => 24, :style => :normal, :align => :center
          pdf.move_down 40
          pdf.text "#{cover_page}", :size => 32, :style => :bold, :align => :center
        end
        get_template_to_merge(pdf, "#{save_dir}/common_pages.pdf")
        
        case cover_page
        when "Advance Commitment Leader Guide"
          get_template_to_merge(pdf, "#{save_dir}/resp/ac_resp.pdf")
          get_template_to_merge(pdf, "#{appendices_dir}/ac.pdf")
          get_template_to_merge(pdf, "#{appendices_dir}/common/giving_potential.pdf")
          add_giving_potential_data(pdf)
        when "Campaign Administrator Guide"
          get_template_to_merge(pdf, "#{save_dir}/resp/cadmin_resp.pdf")
          get_template_to_merge(pdf, "#{appendices_dir}/cadmin_to_ws1.pdf")
          add_cadmin_ws1_data(pdf)
          get_template_to_merge(pdf, "#{appendices_dir}/cadmin_ws1_to_ws2.pdf")
          add_cadmin_ws2_data(pdf)
          get_template_to_merge(pdf, "#{appendices_dir}/cadmin_ws3.pdf")
          add_cadmin_ws3_data(pdf)
          get_template_to_merge(pdf, "#{appendices_dir}/cadmin_ws3_to_ws4.pdf")
          add_cadmin_ws4_data(pdf)
          get_template_to_merge(pdf, "#{appendices_dir}/cadmin_ws5.pdf")
          add_cadmin_ws5_data(pdf)
          get_template_to_merge(pdf, "#{appendices_dir}/cadmin_to_end.pdf")
        when "Campaign Chair Guide"
          get_template_to_merge(pdf, "#{save_dir}/resp/chair_resp.pdf")
          get_template_to_merge(pdf, "#{appendices_dir}/chair.pdf")
          get_template_to_merge(pdf, "#{appendices_dir}/common/giving_potential.pdf")
          add_giving_potential_data(pdf)
        when "Children Activity Leader Guide"
          get_template_to_merge(pdf, "#{save_dir}/resp/childs_act_resp.pdf")
          get_template_to_merge(pdf, "#{appendices_dir}/childs_act.pdf")
        when "Contact Leader Guide"
          get_template_to_merge(pdf, "#{save_dir}/resp/contact_resp.pdf")
        when "Event Leader Guide"
          get_template_to_merge(pdf, "#{save_dir}/resp/event_resp.pdf")
          get_template_to_merge(pdf, "#{appendices_dir}/event.pdf")
        when "Follow Up Leader Guide"
          get_template_to_merge(pdf, "#{save_dir}/resp/follow_resp.pdf")
          get_template_to_merge(pdf, "#{appendices_dir}/follow.pdf")
        when "Information Leader Guide"
          get_template_to_merge(pdf, "#{save_dir}/resp/info_resp.pdf")
          get_template_to_merge(pdf, "#{appendices_dir}/info.pdf")
        when "Involvement Leader Guide"
          get_template_to_merge(pdf, "#{save_dir}/resp/involve_resp.pdf")
        when "Pacesetter Leader Guide"
          get_template_to_merge(pdf, "#{save_dir}/resp/pacesetter_resp.pdf")
          get_template_to_merge(pdf, "#{appendices_dir}/pacesetter.pdf")
          get_template_to_merge(pdf, "#{appendices_dir}/common/giving_potential.pdf")
          add_giving_potential_data(pdf)
        when "Pastor Guide"
          get_template_to_merge(pdf, "#{save_dir}/resp/pastor_resp.pdf")
          get_template_to_merge(pdf, "#{appendices_dir}/pastor.pdf")
          get_template_to_merge(pdf, "#{appendices_dir}/common/giving_potential.pdf")
          add_giving_potential_data(pdf)
        when "Prayer Leader Guide"
          get_template_to_merge(pdf, "#{save_dir}/resp/prayer_resp.pdf")
          get_template_to_merge(pdf, "#{appendices_dir}/prayer.pdf")
        when "Print Leader Guide"
          get_template_to_merge(pdf, "#{save_dir}/resp/print_resp.pdf")
        when "Visual Communications Leader Guide"
          get_template_to_merge(pdf, "#{save_dir}/resp/visual_resp.pdf")
          get_template_to_merge(pdf, "#{appendices_dir}/visual.pdf")
        when "Youth Leader Guide"
          get_template_to_merge(pdf, "#{save_dir}/resp/youth_resp.pdf")
          get_template_to_merge(pdf, "#{appendices_dir}/youth.pdf")
        end
      end
    end
  end
  
  # LOAD TEMPLATES: concat template and saved PDFs
  def create_common_pages(manual_common_pages, save_dir)
    block_calendar = "#{save_dir}/block_calendar.pdf"
      
    Prawn::Document.generate("#{save_dir}/common_pages.pdf", {:page_size => 'A4', :skip_page_creation => true}) do |pdf|
      get_template_to_merge(pdf, manual_common_pages[1]) # Index / Contact page
      add_contacts_data(pdf)
      
      get_template_to_merge(pdf, manual_common_pages[2]) # upto Gift Profile page
      get_template_to_merge(pdf, manual_common_pages[3]) # Gift Profile Chart
      add_gift_profile_data(pdf)
      
      get_template_to_merge(pdf, block_calendar)
      
      get_template_to_merge(pdf, manual_common_pages[4]) # upto Enlistment page 1
      add_enlistment_page1_data(pdf)
      
      get_template_to_merge(pdf, manual_common_pages[5]) # Enlistment page 2
      add_enlistment_page2_data(pdf)
      
      get_template_to_merge(pdf, manual_common_pages[6]) # upto Involvement pages
    end
  end
  
  def create_single_addendum(addendums)
    doc_name_stripped = addendums[1].split('/')[-1]
    Prawn::Document.generate("pdfs/campaign_docs/#{@campaign.id}/#{doc_name_stripped}", {:page_size => 'A4', :skip_page_creation => true}) do |pdf|
      get_template_to_merge(pdf, addendums[1])
      add_AC2_data(pdf)
    end
  end
  
  def create_worksheets(worksheets, save_dir)
    worksheet_save_dir = save_dir+'/manuals'
    worksheets.each do |path_to_doc|
      doc_name_stripped = path_to_doc.split('/')[-1]
      Prawn::Document.generate("#{worksheet_save_dir}/#{doc_name_stripped}", {:page_size => 'A4', :skip_page_creation => true}) do |pdf|
        get_template_to_merge(pdf, path_to_doc)
        case doc_name_stripped
        when "AC1-en.pdf"
          add_AC1_data(pdf)
        when "AC2-en.pdf"
          add_AC2_data(pdf)
        when "AC3-en.pdf"
          add_AC3_data(pdf)
        when "CT1-en.pdf"
          add_CT1_data(pdf)
        when "CT2-en.pdf"
          add_CT2_data(pdf)
        when "CT3-en.pdf"
          add_CT3_data(pdf)
        when "CT4-en.pdf"
          add_CT4_data(pdf)
        when "CT5-en.pdf"
          add_CT5_data(pdf)
        when "CT6-en.pdf"
          add_CT6_data(pdf)
        when "CT7-en.pdf"
          add_CT7_data(pdf)
        when "IN1-en.pdf"
          add_IN1_data(pdf)
        when "IN2-en.pdf"
          add_IN2_data(pdf)
        end
      end
    end
  end
  
  def add_AC1_data(pdf)
    default_leading 5
    get_campaign_title(pdf)
    
    pdf.bounding_box([250, 237], :width => 270) do
      pdf.text "#{formatted_datetime_year(campaign.event.ac_mtg_3)}", :size => 10, :align => :left
      pdf.move_down 19
      pdf.text "#{formatted_datetime_year(campaign.event.ac_host_orient)}", :size => 10, :align => :left
      pdf.move_down 19
      pdf.text "#{formatted_date_vari_begin(campaign.event.ac_res_calls_dates)} - #{formatted_date_vari_end(campaign.event.ac_res_calls_end)}", :size => 10, :align => :left
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
    get_campaign_title(pdf)
    
    pdf.draw_text "#{formatted_date(campaign.event.ac_res_calls_dates)}.", :at => [333, 533], :size => 10, :style => :bold
    pdf.draw_text "(from)", :at => [239, 418], :size => 9, :style => :italic
    pdf.draw_text "#{campaign.name}.", :at => [265, 418], :size => 9, :style => :bold_italic
    pdf.draw_text "#{formatted_date_to_tomorrow(campaign.event.parish_wide_event_dates)}.", :at => [247, 115], :size => 11, :style => :bold
  end
  def add_AC3_data(pdf)
    get_campaign_title_no_loc(pdf)
  end
  def add_CT1_data(pdf)
    get_campaign_title(pdf)
    
    pdf.draw_text "#{formatted_datetime_year(campaign.event.contact_team_asst_trng_1)}", :at => [100, 107], :size => 10
    pdf.draw_text "#{formatted_datetime_year(campaign.event.contact_team_trng_1)}", :at => [315, 107], :size => 10
    pdf.draw_text "#{formatted_date_vari_begin(campaign.event.info_calls_dates)} - #{formatted_date_vari_end(campaign.event.info_calls_end)}", :at => [285, 88], :size => 10
    pdf.draw_text "#{formatted_date_vari_begin(campaign.event.special_event_calls_dates)} - #{formatted_date_vari_end(campaign.event.special_event_calls_end)}", :at => [285, 72], :size => 10
    pdf.draw_text "#{formatted_date_vari_begin(campaign.event.celebration_wknd_calls_dates)} - #{formatted_date_vari_end(campaign.event.celebration_wknd_calls_end)}", :at => [272, 56], :size => 10
  end
  def add_CT2_data(pdf)
    get_campaign_title(pdf)
    
    pdf.text_box "#{formatted_datetime_year(campaign.event.contact_team_asst_trng_1)}", :at => [135, 572], :width => 270, :size => 12, :style => :bold, :align => :center
    pdf.draw_text "#{campaign.enlistment.contact_each_enlist}", :at => [282, 500], :size => 11, :style => :bold
    pdf.draw_text "#{formatted_datetime_year(campaign.event.contact_team_trng_1)}", :at => [285, 361.5], :size => 11
    pdf.bounding_box([275, 298.5], :width => 270) do
      pdf.text "#{formatted_date_vari_begin(campaign.event.info_calls_dates)} - #{formatted_date_vari_end(campaign.event.info_calls_end)}", :size => 11, :align => :left
      pdf.move_down 4
      pdf.text "#{formatted_date_vari_begin(campaign.event.special_event_calls_dates)} - #{formatted_date_vari_end(campaign.event.special_event_calls_end)}", :size => 11, :align => :left
      pdf.move_down 4
      pdf.text "#{formatted_date_vari_begin(campaign.event.celebration_wknd_calls_dates)} - #{formatted_date_vari_end(campaign.event.celebration_wknd_calls_end)}", :size => 11, :align => :left
    end
  end
  def add_CT3_data(pdf)
    get_campaign_title(pdf)
  end
  def add_CT4_data(pdf)
    get_campaign_title(pdf)
    
    pdf.draw_text "#{formatted_date_vari_begin(campaign.event.info_calls_dates)} - #{formatted_date_vari_end(campaign.event.info_calls_end)}", :at => [210, 301.5], :size => 10, :style => :bold
    pdf.draw_text "#{campaign.name}.", :at => [230.5, 138.5], :size => 9, :style => :bold_italic
    pdf.draw_text "#{formatted_date_vari_begin(campaign.event.information_act_dates)} - #{formatted_date_vari_end(campaign.event.information_act_end)},", :at => [74, 125], :size => 9, :style => :bold
  end
  def add_CT5_data(pdf)
    get_campaign_title(pdf)
    
    pdf.draw_text "#{formatted_date_to_tomorrow(campaign.event.parish_wide_event_dates)}", :at => [293, 518], :size => 10, :style => :bold
    pdf.draw_text "#{formatted_date_vari_begin(campaign.event.special_event_calls_dates)} - #{formatted_date_vari_end(campaign.event.special_event_calls_end)}", :at => [245, 425.5], :size => 10, :style => :bold
    pdf.draw_text "#{campaign.name}.", :at => [230.5, 381.5], :size => 9, :style => :bold_italic
  end
  def add_CT6_data(pdf)
    get_campaign_title(pdf)
  end
  def add_CT7_data(pdf)
    get_campaign_title_no_loc(pdf)
    
    pdf.draw_text "#{formatted_date_vari_begin(campaign.event.celebration_wknd_calls_dates)} - #{formatted_date_vari_end(campaign.event.celebration_wknd_calls_end)}", :at => [247, 363], :size => 10, :style => :bold
    pdf.draw_text "#{campaign.name}.", :at => [216, 281.5], :size => 9, :style => :bold_italic
    pdf.draw_text "#{formatted_date_to_tomorrow(campaign.event.celebration_mass_dates)}.", :at => [313.6, 210], :size => 9, :style => :bold_italic
  end
  def add_IN1_data(pdf)
    get_campaign_title(pdf)
    
    pdf.text_box "#{formatted_datetime_year(campaign.event.info_team_trng_1)}", :at => [137, 110.5], :width => 270, :size => 11, :style => :bold, :align => :center
    pdf.text_box "#{formatted_date_vari_begin(campaign.event.information_act_dates)} - #{formatted_date_vari_end(campaign.event.information_act_end)}", :at => [137, 63], :width => 270, :size => 11, :style => :bold, :align => :center
  end
  def add_IN2_data(pdf)
    get_campaign_title_no_loc(pdf)
  end
  
  def get_campaign_title(pdf)
    pdf.bounding_box([135, 703], :width => 270) do
      pdf.text "#{campaign.name}", :size => 18, :style => :bold, :align => :center
      pdf.move_down 1
      pdf.text "#{campaign.city}, #{campaign.state}", :size => 12, :style => :bold, :align => :center
    end
  end
  def get_campaign_title_no_loc(pdf)
    pdf.bounding_box([135, 703], :width => 270) do
      pdf.text "#{campaign.name}", :size => 18, :style => :bold, :align => :center
    end
  end
  
  def get_template_to_merge(pdf, template)
    if (template)
      pdf_pages = Prawn::Document.new(:template => template).page_count
      (1..pdf_pages).each do |i|
        pdf.start_new_page(:template => template, :template_page => i)
      end
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
    pdf.formatted_text_box [{ :text => "Click for an online version of this document",
      :color => "0000FF", :link => "https://link.com"}], :at => [20, 20]
  end
  
  def add_giving_potential_data(pdf)
    pdf.draw_text "#{number_to_currency(gift_profile.goal, :precision => 0)}", :at => [110, 621], :size => 11, :style => :bold
    pdf.draw_text "#{number_to_currency(gift_profile.t1_gift_amount_1, :precision => 0)}", :at => [250, 532]
    pdf.draw_text "#{number_to_currency(gift_profile.t1_gift_amount_2, :precision => 0)}", :at => [250, 437]
    pdf.draw_text "#{number_to_currency(gift_profile.t1_gift_amount_3, :precision => 0)}", :at => [250, 320]
    pdf.draw_text "#{number_to_currency(gift_profile.t1_gift_amount_4, :precision => 0)}", :at => [250, 178]
    pdf.draw_text "#{user.name}.", :at => [22, 42], :size => 10
  end
    
  
  def add_gift_profile_data(pdf)
    pdf.bounding_box([135, 680], :width => 270) do
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
      pdf.text "#{multiply((multiply(campaign.training_sheet.man_contact, campaign.enlistment.contact_enlist)), campaign.enlistment.contact_each_enlist)}", :align => :center, :size => size
      pdf.move_down 6
      pdf.text "#{sum((multiply((multiply(campaign.training_sheet.man_contact, campaign.enlistment.contact_enlist)), campaign.enlistment.contact_each_enlist)), campaign.training_sheet.man_contact)}", :align => :center, :size => size
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
  
  #Campaign Admin Worksheet Data for Appendix
  def add_cadmin_ws1_data(pdf)
    pdf.draw_text "#{campaign.training_sheet.man_contact}", :at => [94.5, 552.5], :size => 11, :style => :bold
    pdf.draw_text "#{multiply(campaign.training_sheet.man_contact, campaign.enlistment.contact_enlist)}", :at => [91, 462.5], :size => 11, :style => :bold
    pdf.draw_text "#{campaign.enlistment.contact_each_enlist}", :at => [71.5, 418.5], :size => 11, :style => :bold
    pdf.draw_text "#{formatted_datetime_year(campaign.event.contact_team_asst_trng_1)}.", :at => [36.5, 272], :size => 11, :style => :bold
  end
  def add_cadmin_ws2_data(pdf)
    pdf.draw_text "#{sum((multiply((multiply(campaign.training_sheet.man_contact, campaign.enlistment.contact_enlist)), campaign.enlistment.contact_each_enlist)), campaign.training_sheet.man_contact)}", :at => [81, 629], :size => 11, :style => :bold
    pdf.draw_text "#{formatted_datetime_year(campaign.event.contact_team_trng_1)}", :at => [36.5, 363.5], :size => 11, :style => :bold
  end
  def add_cadmin_ws3_data(pdf)
    pdf.draw_text "#{sum((multiply(campaign.training_sheet.man_info, campaign.enlistment.info_enlist)), campaign.training_sheet.man_info)}", :at => [91.5, 610], :size => 11, :style => :bold
    pdf.draw_text "#{formatted_datetime_year(campaign.event.info_team_trng_1)}", :at => [36.5, 523.5], :size => 11, :style => :bold
  end
  def add_cadmin_ws4_data(pdf)
    pdf.draw_text "#{campaign.training_sheet.man_ac}", :at => [91.5, 563], :size => 11, :style => :bold
    pdf.draw_text "#{campaign.enlistment.ac_enlist}", :at => [72, 460.5], :size => 11, :style => :bold
    pdf.draw_text "#{formatted_datetime_year(campaign.event.ac_mtg_2)}", :at => [51, 400], :size => 11, :style => :bold
  end
  def add_cadmin_ws5_data(pdf)
    ac_total = "#{sum((multiply(campaign.training_sheet.man_ac, campaign.enlistment.ac_enlist)), campaign.training_sheet.man_ac)}"
    pdf.draw_text ac_total, :at => [149, 482], :size => 11, :style => :bold
    pdf.draw_text ac_total, :at => [174, 394], :size => 11
    pdf.draw_text ac_total, :at => [149, 351.5], :size => 11, :style => :bold
    pdf.draw_text "#{formatted_datetime_year(campaign.event.ac_host_orient)}.", :at => [183, 118], :size => 11, :style => :bold
  end
  
end