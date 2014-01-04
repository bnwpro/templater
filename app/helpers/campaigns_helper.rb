module CampaignsHelper
  def list_or_init(data)
    collection = data
    collection.any? ? collection : collection.build
    #list_last(collection)
  end
  def show_if_exists(data)
    data unless @campaign.training_sheet.nil?
  end
  def list_last(data)
    collection = data
    collection.build
  end
  
  def multiply(*args)
    args.map.inject(:*)
  end
  
  def sum(*args)
    args.sum
  end
  
  def show_if_exists_on_s3?
    url = "https://s3.amazonaws.com"
    calendar_bucket = "ofwc_bc_directory"
    calendar_name = "block_calendar_cid_#{@campaign.id}.pdf"
    
    s3 = AWS::S3.new(:region => "us-east-1")
    
    calendar = s3.buckets[calendar_bucket].objects[calendar_name]
    if calendar.exists?
      return true
    else
      return false
    end
    #puts calendar
  end
  
end
