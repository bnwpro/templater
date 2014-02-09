class ZipDocs
  require 'rubygems'
  require 'zip'
  
  def zip_docs(options = {})
    tmp_docs_dir = "tmp/documents"
    FileUtils.mkdir_p(tmp_docs_dir)
    campaign_name = options[:campaign_name]
    campaign_city = options[:campaign_city]
    files = options[:selected_files]
    name = options[:name].tr(" ", "_")
    url = "https://s3.amazonaws.com"
    _campaign_name_dir = "#{campaign_name.tr(" ", "_").dup}_#{campaign_city.tr(" ", "_").dup}"
    company_suffix = "_ofwc"
    s3_campaign_bucket = _campaign_name_dir.downcase + company_suffix
    
    s3 = AWS::S3.new
    
    bucket = s3.buckets[s3_campaign_bucket]
    if bucket.exists?
      temp_zip = File.join("tmp/documents/#{name}.zip")
      
      # Save files to zip to tmp directory
      files.each do |files_to_zip|
        bucket.objects.each do |pdf|
          if files_to_zip == pdf.key
            pdffile = [pdf]
            pdffile.each do |zf|
              File.open(File.join("tmp/documents/#{pdf.key}"), 'wb') do |file|
                zf.read do |chunk|
                  file.write(chunk)
                end
              end
            end
          end
        end
      end
      
      # Zip files in tmp, then delete
      Zip::File.open(temp_zip, Zip::File::CREATE) do |zipfile|
        temp_files_to_zip = Dir.glob(File.join("tmp/documents/", '*'))
        #puts temp_files_to_zip
        temp_files_to_zip.each do |filename|
          name = File.basename(filename)
          zipfile.add(name, filename)
        end
      end
      
      # Send zip archive to S3 Bucket
      S3Upload.new.send_to_s3(files: [temp_zip], owner: _campaign_name_dir)
      
      # Delete zip archive from tmp directory
      FileUtils.rm Dir.glob(File.join("tmp/documents/", '*'))
      #FileUtils.rm temp_zip
    end
  end
  
end