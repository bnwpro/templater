class GiftProfilesController < ApplicationController
  
  before_action :set_gift_profile, only: [:show, :edit, :update, :destroy]

  before_filter :get_campaign_and_user
    
  layout "campaigns"

  # GET /enlistment
  # GET /enlistment.json
  def index
    @gift_profile = @campaign.gift_profile
    if @gift_profile.nil?
      redirect_to new_user_campaign_gift_profile_path(@user, @campaign)
    end
  end

  # GET /enlistment/1
  # GET /enlistment/1.json
  def show
    @gift_profile = @campaign.gift_profile(params[:id])
  end

  # GET /enlistment/new
  def new
    @campaign = Campaign.find(params[:campaign_id])
    @gift_profile = @campaign.build_gift_profile
  end

  # GET /enlistments/1/edit
  def edit
    @gift_profile = @campaign.gift_profile(params[:id])
    @tier_1_gifts = [@gift_profile.t1_gifts_1, @gift_profile.t1_gifts_2, @gift_profile.t1_gifts_3, @gift_profile.t1_gifts_4, @gift_profile.t1_gifts_5, @gift_profile.t1_gifts_6]
    @tier_2_gifts = [@gift_profile.t2_gifts_1, @gift_profile.t2_gifts_2, @gift_profile.t2_gifts_3, @gift_profile.t2_gifts_4, @gift_profile.t2_gifts_5, @gift_profile.t2_gifts_6, @gift_profile.t2_gifts_7]
    @tier_3_gifts = [@gift_profile.t3_gifts_1, @gift_profile.t3_gifts_2, @gift_profile.t3_gifts_3, @gift_profile.t3_gifts_4, @gift_profile.t3_gifts_5, @gift_profile.t3_gifts_6]
    @tier_1_total_amount = [@gift_profile.t1_gift_amount_1, @gift_profile.t1_gift_amount_2, @gift_profile.t1_gift_amount_3, @gift_profile.t1_gift_amount_4, @gift_profile.t1_gift_amount_5, @gift_profile.t1_gift_amount_6]
    @tier_2_total_amount = [@gift_profile.t2_gift_amount_1, @gift_profile.t2_gift_amount_2, @gift_profile.t2_gift_amount_3, @gift_profile.t2_gift_amount_4, @gift_profile.t2_gift_amount_5, @gift_profile.t2_gift_amount_6, @gift_profile.t2_gift_amount_7]
    @tier_3_total_amount = [@gift_profile.t3_gift_amount_1, @gift_profile.t3_gift_amount_2, @gift_profile.t3_gift_amount_3, @gift_profile.t3_gift_amount_4, @gift_profile.t3_gift_amount_5, @gift_profile.t3_gift_amount_6]
  end

  # POST /enlistments
  # POST /enlistments.json
  def create
    @gift_profile = @campaign.build_gift_profile(gift_profile_params)

    respond_to do |format|
      if @gift_profile.save
        format.html { redirect_to user_campaign_path(@user, @campaign), notice: 'Gift Profile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @gift_profile }
      else
        format.html { render action: 'new' }
        format.json { render json: @gift_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enlistment/1
  # PATCH/PUT /enlistment/1.json
  def update
    @gift_profile = @campaign.gift_profile(params[:id])
    respond_to do |format|
      if @gift_profile.update(gift_profile_params)
        format.html { redirect_to user_campaign_path(@user, @campaign), notice: 'Gift Profile was successfully updated.' }
        format.js
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @gift_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enlistment/1
  # DELETE /enlistment/1.json
  def destroy
    @gift_profile = @campaign.gift_profile(params[:id])
    @gift_profile.destroy
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
    def set_gift_profile
      @gift_profile = GiftProfile.find_by_campaign_id(params[:campaign_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gift_profile_params
      params.require(:gift_profile).permit(:campaign_id,
      :goal,
      :t1_gifts_1, :t1_gifts_2, :t1_gifts_3, :t1_gifts_4, :t1_gifts_5, :t1_gifts_6,
      :t1_gift_amount_1, :t1_gift_amount_2, :t1_gift_amount_3, :t1_gift_amount_4, :t1_gift_amount_5, :t1_gift_amount_6,
      :t2_gifts_1, :t2_gifts_2, :t2_gifts_3, :t2_gifts_4, :t2_gifts_5, :t2_gifts_6, :t2_gifts_7,
      :t2_gift_amount_1, :t2_gift_amount_2, :t2_gift_amount_3, :t2_gift_amount_4, :t2_gift_amount_5, :t2_gift_amount_6, :t2_gift_amount_7,
      :t3_gifts_1, :t3_gifts_2, :t3_gifts_3, :t3_gifts_4, :t3_gifts_5, :t3_gifts_6,
      :t3_gift_amount_1, :t3_gift_amount_2, :t3_gift_amount_3, :t3_gift_amount_4, :t3_gift_amount_5, :t3_gift_amount_6,
      :remainder)
    end
end
