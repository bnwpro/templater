class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  
  before_filter :get_campaign_and_user

  # GET /events
  # GET /events.json
  def index
    @event = @campaign.event
    if @event.nil?
      redirect_to new_user_campaign_event_path(@user, @campaign)
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = @campaign.event(params[:id])
    
  end

  # GET /events/new
  def new
    @campaign = Campaign.find(params[:campaign_id])
    @event = @campaign.build_event
  end

  # GET /events/1/edit
  def edit
    @event = @campaign.event(params[:id])
    #@event = Event.find_by_campaign_id(params[:campaign_id])
    
  end

  # POST /events
  # POST /events.json
  def create
    @event = @campaign.build_event(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to user_campaign_events_path(@user, @campaign), notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @event = @campaign.event(params[:id])
    
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to user_campaign_events_path(@user, @campaign), notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = @campaign.event(params[:id])
    @event.destroy
    
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
    def set_event
      #@event = Event.find(params[:id])
      #@campaign = Campaign.find(params[:campaign_id])
      #@event = @campaign.event(params[:id])
      @event = Event.find_by_campaign_id(params[:campaign_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:date, :campaign_id,
      :leadership_team_trng,
      :campaign_admin_trng,
      :involvement_ldr_trng,
      :pastor_cmp_mtg_1,
      :prayer_ldr_trng,
      :print_vis_comm_mtg_1,
      :event_ldr_trng,
      :childrens_act_ldr_trng,
      :contact_ldr_trng,
      :info_ldr_trng,
      :youth_act_ldr_cons_mtg,
      :ac_mtg_1,
      :pacesetter_gift_pln_mtg_1,
      :intro_ldrshp_team_dates,
      :intro_ldrshp_team_end,
      :leadership_team_rpt_mtg_1,
      :pastor_cmp_mtg_2,
      :print_vis_comm_mtg_2,
      :contact_team_asst_trng_1,
      :contact_team_asst_trng_2,
      :ac_mtg_2,
      :pacesetter_gift_pln_mtg_2,
      :leadership_team_rpt_mtg_2,
      :pastor_cmp_mtg_3,
      :contact_team_trng_1,
      :contact_team_trng_2,
      :contact_team_trng_3,
      :info_team_trng_1,
      :info_team_trng_2,
      :ac_mtg_3,
      :pacesetter_gift_pln_mtg_3,
      :leadership_team_rpt_mtg_3,
      :follow_up_mtg,
      :ac_host_orient,
      :commit_wknd_mtg_pas_cons,
      :pacesetter_gift_rpt_mtg,
      :leadership_team_rpt_mtg_4,
      :information_act_dates,
      :information_act_end,
      :information_act_2_dates,
      :information_act_2_end,
      :weekend_1_dates,
      :weekend_2_dates,
      :ac_gather_1,
      :ac_gather_2,
      :ac_gather_3,
      :ac_gather_4,
      :youth_invlvm_wknd_dates,
      :youth_commt_event,
      :weekend_3_dates,
      :weekend_4_dates,
      :parish_wide_event_dates,
      :celebration_mass_dates,
      :mail_fact_sheet,
      :mail_rmng_info_pkts,
      :mail_ac_invt,
      :mail_newsletter,
      :mail_spc_event_invt,
      :mail_commt_card,
      :setup_info_booth,
      :info_calls_dates,
      :info_calls_end,
      :special_event_calls_dates,
      :special_event_calls_end,
      :celebration_wknd_calls_dates,
      :celebration_wknd_calls_end,
      :ac_res_calls_dates,
      :ac_res_calls_end)
    end
end
