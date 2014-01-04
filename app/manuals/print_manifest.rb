class PrintManifest < Manual
  
  def create_print_manifest(options = {})
    campaign = options[:data]
    save_dir = options[:path]
    manual_save_dir = save_dir+'/manuals'
    Dir.mkdir(manual_save_dir) unless File.exists?(manual_save_dir)
    table_data = [["Count", "Filename 'pr_'"],
    ["#{campaign.training_sheet.man_ac}", "Advance_Commitment_Leader_Guide.pdf"],
    ["#{campaign.training_sheet.man_camp_admin}", "Campaign_Administrator_Guide.pdf"],
    ["#{campaign.training_sheet.man_camp_chair}", "Campaign_Chair_Guide.pdf"],
    ["#{campaign.training_sheet.man_childs_act}", "Children's_Activity_Leader_Guide.pdf"],
    ["#{campaign.training_sheet.man_contact}", "Contact_Leader_Guide.pdf"],
    ["#{campaign.training_sheet.man_spc_event}", "Event_Leader_Guide.pdf"],
    ["#{campaign.training_sheet.man_follow_up}", "Follow_Up_Leader_Guide.pdf"],
    ["#{campaign.training_sheet.man_info}", "Information_Leader_Guide.pdf"],
    ["#{campaign.training_sheet.man_invlvm}", "Involvement_Leader_Guide.pdf"],
    ["#{campaign.training_sheet.man_pace_gifts}", "Pacesetter_Leader_Guide.pdf"],
    ["#{campaign.training_sheet.man_pastor}", "Pastor_Guide.pdf"],
    ["#{campaign.training_sheet.man_prayer}", "Prayer_Leader_Guide.pdf"],
    ["#{campaign.training_sheet.man_print_comm}", "Print_Leader_Guide.pdf"],
    ["#{campaign.training_sheet.man_vis_comm}", "Visual_Communications_Leader_Guide.pdf"],
    ["#{campaign.training_sheet.man_youth}", "Youth_Leader_Guide.pdf"],
    ["1", "Program_Manager's_Manual.pdf"],
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
    Prawn::Document.generate("#{manual_save_dir}/PrintReport.pdf", {:page_size => 'LETTER', :skip_page_creation => true}) do |pdf|
      pdf.start_new_page
      pdf.draw_text "Print Report for: #{campaign.name}, #{campaign.city}", :at => [25, 730]
      pdf.draw_text "Created: #{formatted_datetime_year(Time.now)}", :at => [300, 730]
      pdf.move_down 10
      pdf.table(table_data, :header => true)
    end
  end
end