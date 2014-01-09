class PositionManuals < Manual
  
  attr_accessor :campaign
  
  def create_cover_pages(options = {})
    manual_titles = options[:manual_titles]
    campaign_dir = options[:campaign_dir]
    manual_campaign_docs_dir = options[:manual_campaign_docs_dir]
    self.campaign = options[:campaign]
    delivery_method = options[:delivery]
    appendices_dir = "pdfs/templates/appendices"
    resp = Document.new.resp_doc
    #name = resp.first
    manual_titles.each do |cover_page|
      titles = cover_page.dup
      if delivery_method == "print"
        titles.insert(0, 'pr_')
      elsif delivery_method == "electronic"
        titles
      end
      #titles_underscore = cover_page.strip
      Prawn::Document.generate("#{manual_campaign_docs_dir}/#{titles.tr(" ", "_")}.pdf", {:page_size => 'LETTER', :skip_page_creation => true}) do |pdf|
        pdf.start_new_page(:template => "pdfs/templates/intro_pages/1_cover.pdf")
        pdf.fill_color "000000"
        pdf.bounding_box([100, 600], :width => 375) do
          pdf.text "#{campaign.name}", :size => 32, :style => :bold, :align => :center
          pdf.move_down 40
          pdf.text "#{campaign.city}, #{campaign.state}", :size => 24, :style => :normal, :align => :center
          pdf.move_down 40
          pdf.text "#{cover_page}", :size => 32, :style => :bold, :align => :center
        end
        PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/common_pages.pdf")
        PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/common_pages_enlist.pdf") unless delivery_method == "print"
        
        case cover_page
        when "Advance Commitment Leader Guide"
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/ac_resp.pdf")
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/ac.pdf") unless delivery_method == "print"
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/giving_potential.pdf") unless delivery_method == "print"
        when "Campaign Administrator Guide"
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/cadmin_resp.pdf")
          #if delivery_method == "electronic"
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
            #end
        when "Campaign Chair Guide"
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/chair_resp.pdf")
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/chair.pdf") unless delivery_method == "print"
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/giving_potential.pdf") unless delivery_method == "print"
        when "Children Activity Leader Guide"
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/childs_act_resp.pdf")
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/childs_act.pdf") unless delivery_method == "print"
        when "Contact Leader Guide"
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/contact_resp.pdf")
        when "Event Leader Guide"
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/event_resp.pdf")
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/event.pdf") unless delivery_method == "print"
        when "Follow Up Leader Guide"
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/follow_resp.pdf")
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/follow.pdf") unless delivery_method == "print"
        when "Information Leader Guide"
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/info_resp.pdf")
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/info.pdf") unless delivery_method == "print"
        when "Involvement Leader Guide"
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/involve_resp.pdf")
        when "Pacesetter Leader Guide"
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/pacesetter_resp.pdf")
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/pacesetter.pdf") unless delivery_method == "print"
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/giving_potential.pdf") unless delivery_method == "print"
        when "Pastor Guide"
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/pastor_resp.pdf")
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/pastor.pdf") unless delivery_method == "print"
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/giving_potential.pdf") unless delivery_method == "print"
        when "Prayer Leader Guide"
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/prayer_resp.pdf")
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/prayer.pdf") unless delivery_method == "print"
        when "Print Leader Guide"
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/print_resp.pdf")
        when "Visual Communications Leader Guide"
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/visual_resp.pdf")
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/visual.pdf") unless delivery_method == "print"
        when "Youth Leader Guide"
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{campaign_dir}/resp/youth_resp.pdf")
          PdfMerger.get_template_to_merge(pdf: pdf, path: "#{appendices_dir}/youth.pdf") unless delivery_method == "print"
        end
      end
    end
  end
end