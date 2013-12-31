module EventsHelper
  def form_date_field
    form.object.date.strftime('%B, %-d %-I:%M %p') if form.object.date
  end
  
  def show_pdfs_if_exist_
		file_path = Rails.public_path.join('pdfs', 'campaign_docs', "#{@campaign.name}", "manuals")
	  if File.exist?(file_path)
      #Dir.chdir(file_path)
      files = Dir[File.join(file_path, '*' '.pdf')]
      base_path = Pathname.new(file_path)
      @files = files.collect do |file|
        Pathname.new(file).relative_path_from(base_path)
      end
		  #@files = Dir.glob("#{file_path}/*").reject {|x| x.match /^\./}
      #@files = Dir.glob(Rails.root.join("#{file_path}/*/*")).reject {|x| x.match /^\./}
		end
  end
  
  def show_pdfs_if_exist
		file_path = Rails.public_path.join('pdfs', 'campaign_docs', "#{@campaign.name}", "manuals")
	  if File.exist?(file_path)
      #Dir.chdir(file_path)
      files = Dir[File.join(file_path, '*' '.pdf')]
      @files = files.collect do |file|
        file.gsub(/.*.\/*public/, '')
      end
		  #@files = Dir.glob("#{file_path}/*").reject {|x| x.match /^\./}
      #@files = Dir.glob(Rails.root.join("#{file_path}/*/*")).reject {|x| x.match /^\./}
		end
  end
  
end
