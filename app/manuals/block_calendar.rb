class BlockCalendar
  def get_calendar_if_exists?(options = {})
    id = options[:id]
    
    url = "https://s3.amazonaws.com"
    calendar_bucket = "ofwc_bc_directory"
    calendar_name = "block_calendar_cid_#{id}.pdf"
    
    s3 = AWS::S3.new#(:region => "us-east-1")
    
    calendar = s3.buckets[calendar_bucket].objects[calendar_name]
    if calendar.exists?
      return calendar_name
    else
      return
    end
  end
end