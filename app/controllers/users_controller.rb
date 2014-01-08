class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  #layout :determine_layout
  
  def admin_all
    @campaigns = Campaign.all
    #@user = User.all && @campaigns.find_by(params[:user_id])
  end
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    #redirect_to user_campaigns_path(@user) unless current_user.admin == false
  end

  # GET /users/1
  # GET /users/1.json
  def show
    #redirect_to user_campaigns_path(@user) unless @user.admin?
    respond_to do |format|
      format.html
      format.json
      format.pdf do
        render :pdf                       => 'file.pdf', 
          :template                       => 'users/show_no_links.pdf.erb',
          :disable_internal_links         => true,
          :disable_external_links         => true,
          :page_size                      => 'A4'
      end
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path(@user), notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path(@user), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    begin
      @user.destroy
      flash[:notice] = "User #{@user.name} deleted"
    rescue Exception => e
      flash[:notice] = e.message
    end
    
    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { head :no_content }
    end
  end
  
  # PUT /users/1/mercury_update
  def mercury_update
    user = User.find(params[:id])
    user.name = params[:content][:user_name][:value]
    user.date = params[:content][:user_date][:value]
    user.save!
    render text: ""
  end

  private
    # TODO: check if rendering template from default or user edited database table
    def get_page_from_db
      #template_exists?("index2", _prefixes, false)
      return
    end
    # TODO: Load default or edited layouts
    def determine_layout
      return
      #"../users/index"
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone, :city, :state, :zip, :password, :password_confirmation, :password_digest, :admin)
    end
end
