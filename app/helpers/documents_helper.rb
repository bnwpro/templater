module DocumentsHelper
  
  def get_image_path # Needs absolute path to resolve LOGO for Mercury & wicked_pdf
    #'http://localhost:3000/assets/images/logo_bw.png'
    #path = Rails.public_path.join('assets', 'images', 'logo_bw.png').to_s
    #trim_path = path.gsub(/.*.\/*public/, '')
    #image_path = 
    #return trim_path
    'http://templater-env-9mvpzgknsa.elasticbeanstalk.com/assets/images/logo_bw.png'
  end
end
