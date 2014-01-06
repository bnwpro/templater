class BlockCalendar
  def self.does_calendar_exist?(options = {})
    id = options[:id]
    
    url = "https://s3.amazonaws.com"
    calendar_bucket = "ofwc_bc_directory"
    calendar_name = "block_calendar_cid_#{id}.pdf"
    
    s3 = AWS::S3.new#(:region => "us-east-1")
    
    calendar = s3.buckets[calendar_bucket].objects[calendar_name]
    if calendar.exists?
      return true
    else
      return false
    end
  end
  
  def get_calendar_if_exists(options = {})
    id = options[:id]
    
    url = "https://s3.amazonaws.com"
    calendar_bucket = "ofwc_bc_directory"
    calendar_name = "block_calendar_cid_#{id}.pdf"
    temp_dir = "pdfs/campaign_docs/#{id}/#{calendar_name}"
    
    s3 = AWS::S3.new#(:region => "us-east-1")
    
    calendar = s3.buckets[calendar_bucket].objects[calendar_name]
    if calendar.exists?
      File.open(temp_dir, 'wb') do |file|
        calendar.read do |chunk|
          file.write(chunk)
        end
      end
    else
      return nil
    end
  end
  
end