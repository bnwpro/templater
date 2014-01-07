class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  
  before_filter :get_user, except: [:mercury_update, :admin_all]

  # GET /campaigns
  # GET /campaigns.json
  def index
    #@campaigns = Campaign.all
    @campaigns = @user.campaigns
    #output = Manual.new.to_pdf
    respond_to do |format|
      format.html
      #format.pdf  {send_data output, filename: "hello.pdf", type: "application/pdf", disposition: "inline"}
    end
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
    @campaign = @user.campaigns.find(params[:id])
  end

  # GET /campaigns/new
  def new
    #@campaign = Campaign.new
    @user = User.find(params[:user_id])
    @campaign = @user.campaigns.build
  end

  # GET /campaigns/1/edit
  def edit
    @campaign = @user.campaigns.find(params[:id])
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    #@campaign = Campaign.new(campaign_params)
    @campaign = @user.campaigns.build(campaign_params)
    @enlistment = @campaign.build_enlistment(params[:campaign_id])
    @training_sheet = @campaign.build_training_sheet(params[:campaign_id])
    @gift_profile = @campaign.build_gift_profile(params[:campaign_id])

    respond_to do |format|
      if @campaign.save
        #format.html { redirect_to @campaign, notice: 'Campaign was successfully created.' }
        format.html { redirect_to user_campaigns_path(@user), notice: 'Campaign was successfully created.' }
        format.json { render action: 'show', status: :created, location: @campaign }
      else
        format.html { render action: 'new' }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    @campaign = @user.campaigns.find(params[:id])
    #@campaign.block_calendar = params[:campaign][:block_calendar] # Was deleting block calendar on update
    respond_to do |format|
      if @campaign.update(campaign_params)
        #format.html { redirect_to @campaign, notice: 'Campaign was successfully updated.' }
        format.pdf
        format.html { redirect_to user_campaign_path(@user, @campaign), notice: 'Campaign was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign = @user.campaigns.find(params[:id])
    @campaign.destroy
    respond_to do |format|
      #format.html { redirect_to campaigns_url }
      format.html { redirect_to user_campaigns_path(@user) }
      format.json { head :no_content }
      format.js
    end
  end
  
  # PUT /campaigns/1/mercury_update
  def mercury_update
    campaign = Campaign.find(params[:id])
    document_dir = 'documents/'
    document_name = request.referer.split('/').last
    path = document_dir + document_name
    document = {
      :body => params[:content][:page_content][:value],
      :path => path,
      :format => 'html',
      :locale => 'en',
      :handler => 'erb',
      :partial => 'false',
      :campaign_id => campaign.id
    }
    edited_document = SqlTemplate.find_or_initialize_by(campaign_id: campaign, path: path).update_attributes(document)
    render text: ""
  end
  
  def admin_all
    #@user = session[:user.id]
    @campaigns = Campaign.all
  end

  private
    def get_user
      @user = User.find(params[:user_id])
    end 
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
      params.require(:campaign).permit(:user_id,
      :name,
      :diocese,
      :address,
      :city,
      :state,
      :zip,
      :contact_name,
      :phone,
      :fax,
      :email,
      :url,
      :number_of_families,
      :contribution_income,
      :has_pacesetter,
      :standalone,
      :block_calendar,
      campaign_contacts_attributes:
      [:id, :campaign_id, :description, :name, :address, :city, :state, :zip, :phone, :email, :_destroy])
    end
end
