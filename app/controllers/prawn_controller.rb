class PrawnController < ApplicationController

  def index
    output = Manual.new.to_pdf
    respond_to do |format|
      format.pdf { 
        send_data output, type: "application/pdf", disposition: "attachment"
      }
      format.html {
        render text: "<h1>Use .pdf</h1>".html_safe
      }
    end
  end
end