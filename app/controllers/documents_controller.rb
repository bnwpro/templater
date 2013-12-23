class DocumentsController < ApplicationController
  #before_action :find_default_or_edited_document_in_db, :except => [:generate]
  before_action :find_default_or_edited_document_in_db
  
  before_filter :get_user_campaign_data
  
  def respond  # NOT USED because corresponding ROUTE not being used
  render template: "documents/"+params[:page]
  end
  
  def generate_
    user = @user
    campaign = @campaign
    Manual.new.to_pdf(user, campaign)
  end
  
  def generate
    user = @user
    campaign = @campaign
    Document.first_two_only.each do |title|
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
            :page_size                      => 'A4',
            :lowquality                     => false,
            :formats                        => :html
        end #end format.pdf
      end  #end respond_to
      # Insert code to refresh/updtae Saved PDF listing
    end  #end Document.each
    #Manual.new.to_pdf(user, campaign)
  end  #end generate
  
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
          :page_size                      => 'A4',
          :lowquality                     => false,
          :formats                        => :html,
          #:margin                         => { :right => 20 },
          :footer                         => {:content => render_to_string(:template => 'documents/footer.pdf.erb'), :right => '[page]' }
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
