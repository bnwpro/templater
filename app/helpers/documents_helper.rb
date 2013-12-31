module DocumentsHelper
  
  def get_image_path # Needs absolute path to resolve LOGO for Mercury & wicked_pdf
    #'http://localhost:3000/assets/images/logo_bw.png'
    path = Rails.public_path.join('assets', 'images', 'logo_bw.png')
    return path
  end
end
