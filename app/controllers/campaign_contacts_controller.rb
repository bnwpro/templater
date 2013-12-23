class CampaignContactsController < ApplicationController
  
  before_action :set_campaign_contact, only: [:show, :edit, :update, :destroy]
  validates :email, format: /.+@.+\..+/i, uniqueness: true, length: { within: 5..50}
  
  before_filter :get_campaign_and_user

  # GET /campaign_contacts
  # GET /campaign_contacts.json
  def index
    @campaign_contacts = @campaign.campaign_contacts
    if @campaign_contacts.nil?
      redirect_to new_user_campaign_campaign_contacts_path(@user, @campaign)
    end
  end

  # GET /campaign_contacts/1
  # GET /campaign_contacts/1.json
  def show
    @campaign_contact = @campaign.campaign_contacts.find(params[:id])
  end

  # GET /campaign_contacts/new
  def new
    @campaign = Campaign.find(params[:campaign_id])
    @campaign_contact = @campaign.campaign_contacts.build
  end

  # GET /campaign_contacts/1/edit
  def edit
    @campaign_contact = @campaign.campaign_contacts.find(params[:id])
  end

  # POST /campaign_contacts
  # POST /campaign_contacts.json
  def create
    @campaign_contact = @campaign.campaign_contacts.build(campaign_contact_params)

    respond_to do |format|
      if @campaign_contact.save
        format.html { redirect_to user_campaign_campaign_contacts_path(@user, @campaign), notice: 'Campaign contact was successfully created.' }
        format.json { render action: 'show', status: :created, location: @campaign_contact }
      else
        format.html { render action: 'new' }
        format.json { render json: @campaign_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaign_contacts/1
  # PATCH/PUT /campaign_contacts/1.json
  def update
    @campaign_contact = @campaign.campaign_contacts.find(params[:id])
    
    respond_to do |format|
      if @campaign_contact.update(campaign_contact_params)
        format.html { redirect_to user_campaign_campaign_contacts_path(@user, @campaign), notice: 'Campaign contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @campaign_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaign_contacts/1
  # DELETE /campaign_contacts/1.json
  def destroy
    @campaign_contact = @campaign.campaign_contacts.find(params[:id])
    @campaign_contact.destroy
    
    respond_to do |format|
      format.html { redirect_to user_campaigns_path(@user, @campaign) }
      format.json { head :no_content }
    end
  end

  private
  
    def get_campaign_and_user
      @user = User.find(params[:user_id])
      @campaign = Campaign.find(params[:campaign_id])
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign_contact
      @campaign_contact = CampaignContact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_contact_params
      params.require(:campaign_contact).permit(:campaign_id, :description, :name, :address, :city, :state, :zip, :phone, :email)
    end
end
