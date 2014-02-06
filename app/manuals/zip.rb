class Zip
  require 'rubygems'
  require 'zip'
  
  def zip_docs(options = {})
    campaign_name = options[:campaign_name]
    campaign_city = options[:campaign_city]
    files = options[:selected_files]
    url = "https://s3.amazonaws.com"
    _campaign_name_dir = "#{campaign_name.tr(" ", "_").dup}_#{campaign_city.tr(" ", "_").dup}"
    company_suffix = "_ofwc"
    s3_campaign_bucket = _campaign_name_dir.downcase + company_suffix
    
    s3 = AWS::S3.new
    
    bucket = s3.buckets[s3_campaign_bucket]
    if bucket.exists?
      zipfile_name = "#{s3_campaign_bucket}/archive.zip"
      #zip = Zip::File.new 
      Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
        files.each do |filename|
          zipfile.add(filename)
        end
      end
    end
  end
  
end