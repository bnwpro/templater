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
      #
    end
  end
end