module EventsHelper
  def form_date_field
    form.object.date.strftime('%B, %-d %-I:%M %p') if form.object.date
  end
  # DEPRECATED
  def show_pdfs_if_exist
    _campaign_dir = "#{@campaign.name.tr(" ", "_").dup}"
		file_path = Rails.public_path.join('pdfs', 'campaign_docs', "#{_campaign_dir}", "manuals")
	  if File.exist?(file_path)
      #Dir.chdir(file_path)
      files = Dir[File.join(file_path, '*' '.pdf')]
      @files = files.collect do |file|
        file.gsub(/.*.\/*public/, '')
      end
		end
  end
  
  def get_bucket
    @url = "https://s3.amazonaws.com"
    _campaign_name_dir = "#{@campaign.name.tr(" ", "_").dup}_#{@campaign.city.tr(" ", "_").dup}"
    company_suffix = "_ofwc"
    @s3_campaign_bucket = _campaign_name_dir.downcase + company_suffix
    #puts s3_campaign_bucket
    s3 = AWS::S3.new#(:region => "us-east-1")
    
    @bucket = s3.buckets[@s3_campaign_bucket]
  end
  
  def show_pdfs_if_exist_on_s3?
    self.get_bucket
    
    url = @url
    bucket = @bucket
    s3_campaign_bucket = @s3_campaign_bucket
    
    if bucket.exists?
      @files = []
      bucket.objects.each do |pdf|
        @files << File.join(url, s3_campaign_bucket, pdf.key) unless pdf.key.end_with?(".zip")
      end
      return @files
    else
      return
    end
  end
  
  def show_zips_if_exist_on_s3?
    self.get_bucket
    
    url = @url
    bucket = @bucket
    s3_campaign_bucket = @s3_campaign_bucket
    
    if bucket.exists?
      @files = []
      bucket.objects.each do |pdf|
        @files << File.join(url, s3_campaign_bucket, pdf.key) unless pdf.key.end_with?(".pdf")
        @files << pdf.last_modified unless pdf.key.end_with?(".pdf")
      end
      return @files
    else
      return
    end
  end
  
  
end
