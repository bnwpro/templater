class EnlistmentsController < ApplicationController
  before_action :set_enlistment, only: [:show, :edit, :update, :destroy]
  
  before_filter :get_campaign_and_user

  # GET /enlistment
  # GET /enlistment.json
  def index
    @enlistment = @campaign.enlistment
    if @enlistment.nil?
      redirect_to new_user_campaign_enlistment_path(@user, @campaign)
    end
  end

  # GET /enlistment/1
  # GET /enlistment/1.json
  def show
    @enlistment = @campaign.enlistment(params[:id])
  end

  # GET /enlistment/new
  def new
    @campaign = Campaign.find(params[:campaign_id])
    @enlistment = @campaign.build_enlistment
  end

  # GET /enlistments/1/edit
  def edit
    @enlistment = @campaign.enlistment(params[:id])
  end

  # POST /enlistments
  # POST /enlistments.json
  def create
    @enlistment = @campaign.build_enlistment(enlistment_params)

    respond_to do |format|
      if @enlistment.save
        #format.html { redirect_to user_campaign_enlistments_path(@user, @campaign), notice: 'Enlistment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @enlistment }
      else
        format.html { render action: 'new' }
        format.json { render json: @enlistment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enlistment/1
  # PATCH/PUT /enlistment/1.json
  def update
    @enlistment = @campaign.enlistment(params[:id])
    respond_to do |format|
      if @enlistment.update(enlistment_params)
        #format.html { redirect_to user_campaign_enlistments_path(@user, @campaign), notice: 'Enlistment was successfully updated.' }
        format.js
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @enlistment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enlistment/1
  # DELETE /enlistment/1.json
  def destroy
    @enlistment = @campaign.enlistment(params[:id])
    @enlistment.destroy
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
    def set_enlistment
      @enlistment = Enlistment.find_by_campaign_id(params[:campaign_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enlistment_params
      params.require(:enlistment).permit(:campaign_id, :ac_enlist, :childs_act_enlist, :spc_event_enlist, :contact_enlist, :contact_each_enlist, :info_enlist)
    end
end
