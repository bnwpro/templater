class DocumentsController < ApplicationController
  require 'rubygems'
  require 'zip'
  #before_action :find_default_or_edited_document_in_db, :except => [:generate]
  before_action :find_default_or_edited_document_in_db, :except => [:zip_selected_resp_docs]
  
  before_filter :get_user_campaign_data, :except => [:zip_selected_resp_docs]
  
  def respond  # NOT USED because corresponding ROUTE not being used
  render template: "documents/"+params[:page]
  end
  
  def generate_
    user = @user
    campaign = @campaign
    Manual.new.to_pdf(user, campaign)
    #Manual.new.create_print_manifest(campaign, "pdfs/campaign_docs/#{@campaign.id}")
  end
  
  def generate
    user = @user
    campaign = @campaign
    campaign_root_dir = "pdfs/campaign_docs/#{campaign.id}"
    resp_doc_dir = "pdfs/campaign_docs/#{campaign.id}/resp"
    FileUtils.mkdir_p(resp_doc_dir)
    
    block_calendar = BlockCalendar.does_calendar_exist?(id: @campaign.id)
    #bc_key = block_calendar.key
    if (block_calendar)
      Document.new.resp_doc.each do |title|
        name = "documents/"  + title
        save_file = name.split('/')[-1]
        respond_to do |format|
          format.pdf do
            render :pdf                       => title, #page name
              :file                           => name,
              #:layout                         => 'documents',
              :disposition                    => 'attachment',
              :save_to_file                   => Rails.root.join("pdfs/campaign_docs/#{campaign.id}/resp", "#{save_file}.pdf"),
              :save_only                      => true,
              :disable_internal_links         => true,
              :disable_external_links         => true,
              :page_size                      => 'Letter',
              :lowquality                     => false,
              :formats                        => :html,
              :footer                         => { :right => "__________________________________________________________   #{save_file}onsibility - [page]" }
          end #end format.pdf
          #format.js
        end  #end respond_to
        #format.js
        # Insert code to refresh/updtae Saved PDF listing
      end  #end Document.each
      Manual.new.to_pdf(user, campaign)
    else
      
      flash.now[:error] = "Block Calendar has not been uploaded.  Please upload your Block Calendar to continue."
      raise :error
      #redirect_to user_campaign_path(@user, @campaign), notice: 'Block Calendar has not been uploaded.  Please upload your Block Calendar to continue.'
      return
    end
  end  #end generate
  
  def zip_selected_resp_docs
    @campaign_name = params[:campaign_name]
    @campaign_city = params[:campaign_city]
    @files_to_zip = params[:to_zip]
    @zip_name = params[:zip_file_name]
    #puts @campaign_name, @campaign_city, @files_to_zip
    ZipDocs.new.zip_docs(campaign_name: @campaign_name, campaign_city: @campaign_city, selected_files: @files_to_zip, name: @zip_name)
    head :ok, :content_type => 'text/html'
    #redirect_to :back
  end
  
  def show
    user = @user
    campaign = @campaign
    document_name = "documents/"+ params[:id]
    save_file = document_name.split('/')[-1]
    respond_to do |format|
      format.html { render document_name }
      format.json
      format.pdf do
        render :pdf                       => params[:id], #page name
          :file                           => document_name,
          #:layout                         => 'documents',
          :disposition                    => 'attachment',
          :save_to_file                   => Rails.root.join("pdfs/campaign_docs/#{campaign.id}", "#{save_file}.pdf"),
          :save_only                      => true,
          :disable_internal_links         => true,
          :disable_external_links         => true,
          :page_size                      => 'Letter',
          :lowquality                     => false,
          :formats                        => :html,
          :footer                         => { :right => "__________________________________________________________   #{save_file}onsibility - [page]" }
          #:footer                         => {:content => render_to_string(:template => 'documents/footer.pdf.erb'), :center => '[page]' }
          #Manual.new.to_pdf(user, campaign)
      end
      format.js
    end
  end
  
  # PUT /campaigns/1/mercury_update **NOT USING YET (using method on Campaigns Controller)
  def mercury_update
    campaign = Campaign.find(params[:id])
    document_name = request.referer.split('/').last
    document = {
      :body => params[:content][:page_content][:value],
      :path => 'documents/' + document_name,
      :format => 'html',
      :locale => 'en',
      :handler => 'erb',
      :partial => 'false',
      :campaign_id => campaign.id
    }
    edited_document = SqlTemplate.find_or_create_by(campaign_id: campaign_id)
    edited_document.update(document)
    render text: ""
  end
  
  private
  
  # Queries db to see if SqlTemplate exists with matching campaign_id
  def find_default_or_edited_document_in_db
    campaign_id = Campaign.find(params[:campaign_id])
    if SqlTemplate.exists? campaign_id: campaign_id
      SqlTemplate::Resolver.instance.set_campaign_document(campaign_id)
      prepend_view_path SqlTemplate::Resolver.instance
    else
      append_view_path SqlTemplate::Resolver.instance
    end
  end
  
  def get_user_campaign_data
    @user = User.find(params[:user_id])
    @campaign = Campaign.find(params[:campaign_id])
    #@event = Event.find(params[:event_id])
  end
  
end
