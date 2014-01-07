class TrainingSheetsController < ApplicationController
  
  before_action :set_training_sheet, only: [:show, :edit, :update, :destroy]
  
  before_filter :get_campaign_and_user
  
  layout "campaigns"

  # GET /training_sheets
  # GET /training_sheets.json
  def index
    @training_sheet = @campaign.training_sheet
    if @training_sheet.nil?
      redirect_to new_user_campaign_training_sheet_path(@user, @campaign)
    end
  end

  # GET /training_sheets/1
  # GET /training_sheets/1.json
  def show
    @training_sheet = @campaign.training_sheet(params[:id])
  end

  # GET /training_sheets/new
  def new
    @campaign = Campaign.find(params[:campaign_id])
    @training_sheet = @campaign.build_training_sheet
  end

  # GET /training_sheets/1/edit
  def edit
    @training_sheet = @campaign.training_sheet(params[:id])
  end

  # POST /training_sheets
  # POST /training_sheets.json
  def create
    @training_sheet = @campaign.build_training_sheet(training_sheet_params)

    respond_to do |format|
      if @training_sheet.save
        format.html { redirect_to user_campaign_path(@user, @campaign), notice: 'Training sheet was successfully created.' }
        format.json { render action: 'show', status: :created, location: @training_sheet }
      else
        format.html { render action: 'new' }
        format.json { render json: @training_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /training_sheets/1
  # PATCH/PUT /training_sheets/1.json
  def update
    @training_sheet = @campaign.training_sheet(params[:id])
    respond_to do |format|
      if @training_sheet.update(training_sheet_params)
        format.html { redirect_to user_campaign_path(@user, @campaign), notice: 'Training sheet was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: 'edit' }
        format.json { render json: @training_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /training_sheets/1
  # DELETE /training_sheets/1.json
  def destroy
    @training_sheet = @campaign.training_sheet(params[:id])
    @training_sheet.destroy
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
    def set_training_sheet
      @training_sheet = TrainingSheet.find_by_campaign_id(params[:campaign_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def training_sheet_params
      params.require(:training_sheet).permit(:campaign_id, :print_contact_name, :print_contact_phone, :print_contact_email, :man_ac, :man_camp_admin, :man_camp_chair, :man_childs_act, :man_contact, :man_follow_up, :man_info, :man_invlvm, :man_pace_gifts, :man_prayer, :man_print_comm, :man_spc_event, :man_vis_comm, :man_youth, :man_pastor, :ts_ac1, :ts_ac2, :ts_ac3, :ts_ct1, :ts_ct2, :ts_ct3, :ts_ct4, :ts_ct5, :ts_ct6, :ts_ct7, :ts_it1, :ts_it2)
    end
end
