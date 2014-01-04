class PdfMerger
  private
  def self.get_template_to_merge(options = {})
    pdf_object = options[:pdf]
    path = options[:path]
    if (path)
      pdf_pages = Prawn::Document.new(:template => path).page_count
      (1..pdf_pages).each do |i|
        pdf_object.start_new_page(:template => path, :template_page => i)
      end
    end
  end
  
end