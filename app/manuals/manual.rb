class Manual < Prawn::Document
  
  include ActionView::Helpers::NumberHelper
  include ApplicationHelper
  include GiftProfilesHelper
  
  attr_accessor :user, :campaign
  
  # ENTRY POINT: renders and custom Prawn file to be merged at any point with master.pdf  
  def to_pdf(user, campaign)
    self.user = user
    self.campaign = campaign
    manual_titles_en = Document.new.manual_titles_en
    manual_common_pages_en = Document.new.manual_common_pages_en
    worksheets_en = Document.new.worksheets_en
    
    # Make All Necessary Directories 
    campaign_docs_dir = "pdfs/campaign_docs"
    campaign_dir = File.join(campaign_docs_dir, "#{campaign.id}")
    manual_campaign_docs_dir = File.join(campaign_dir, "manuals")
    FileUtils.mkdir_p(manual_campaign_docs_dir)
    
    block_calendar = BlockCalendar.new.get_calendar_if_exists(id: @campaign.id)
    
    # TESTING AREA
    
    #return
    
    if File.exist?(block_calendar)
      
      CommonPages.new.create_common_pages(cal: block_calendar,
        manual_common_pages: manual_common_pages_en,
        campaign_dir: campaign_dir,
        user: user, campaign: campaign)
      
      PositionManuals.new.create_cover_pages(manual_titles: manual_titles_en,
        campaign_dir: campaign_dir,
        manual_campaign_docs_dir: manual_campaign_docs_dir,
        campaign: campaign, delivery: "electronic")
      
      PositionManuals.new.create_cover_pages(manual_titles: manual_titles_en,
        campaign_dir: campaign_dir,
        manual_campaign_docs_dir: manual_campaign_docs_dir,
        campaign: campaign, delivery: "print")
  
      Worksheets.new.create_worksheets(worksheets: worksheets_en,
        manual_campaign_docs_dir: manual_campaign_docs_dir,
        campaign: campaign)
        
      MasterManual.new.create_master_program_manual(campaign_dir: campaign_dir,
        manual_campaign_dir: manual_campaign_docs_dir,
        campaign: campaign)
      
      PrintManifest.new.create_print_manifest(data: campaign, path: campaign_dir)
    end
    
    move_and_cleanup_files(campaign_dir, manual_campaign_docs_dir)
  end
  
  private
  def move_and_cleanup_files(campaign_dir, manual_campaign_docs_dir)
    origin = manual_campaign_docs_dir
    _campaign_name_dir = "#{campaign.name.tr(" ", "_").dup}"
    origin_docs = Dir.glob(File.join(origin, "*"))
     
    S3Upload.new.send_to_s3(files: origin_docs, owner: _campaign_name_dir)
    
    FileUtils.rm_rf File.join(campaign_dir)
  end
  
  # TEMP
  def create_single_addendum(addendums)
    doc_name_stripped = addendums[1].split('/')[-1]
    Prawn::Document.generate("pdfs/campaign_docs/#{@campaign.id}/#{doc_name_stripped}", {:page_size => 'LETTER', :skip_page_creation => true}) do |pdf|
      PdfMerger.get_template_to_merge(pdf: pdf, path: addendums[1])
      add_AC2_data(pdf)
    end
  end
  
end