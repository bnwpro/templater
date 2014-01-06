class S3Upload

  def send_to_s3(options ={})
    owner = options[:owner]
    files = options[:files]
    
    company_suffix = "_ofwc"
    
    s3 = AWS::S3.new#(:region => "us-east-1")
    
    campaign_bucket = owner.downcase + company_suffix
    remote_bucket = s3.buckets[campaign_bucket]
    unless remote_bucket.exists?
      s3.buckets.create(campaign_bucket, :acl => :public_read)
    end
      
    files.each do |pdfs|
      key = File.basename(pdfs)
      s3.buckets[campaign_bucket].objects[key].write(:file => pdfs, :acl => :public_read)
    end
    
  end
end