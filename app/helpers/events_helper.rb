module EventsHelper
  def form_date_field
    form.object.date.strftime('%B, %-d %-I:%M %p') if form.object.date
  end
  
  def show_pdfs_if_exist
		file_path = Rails.root.join('pdfs', 'campaign_docs', "#{@campaign.id}")
	  if File.exist?(file_path)
      #Dir.chdir(file_path)
		  @files = Dir.glob("#{file_path}/*/*").reject {|x| x.match /^\./}
      #@files = Dir.glob(Rails.root.join("#{file_path}/*/*")).reject {|x| x.match /^\./}
		end
  end
  
end
