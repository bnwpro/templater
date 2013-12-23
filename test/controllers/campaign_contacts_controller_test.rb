require 'test_helper'

class CampaignContactsControllerTest < ActionController::TestCase
  setup do
    @campaign_contact = campaign_contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:campaign_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create campaign_contact" do
    assert_difference('CampaignContact.count') do
      post :create, campaign_contact: { address: @campaign_contact.address, campaign_id: @campaign_contact.campaign_id, city: @campaign_contact.city, description: @campaign_contact.description, email: @campaign_contact.email, name: @campaign_contact.name, phone: @campaign_contact.phone, state: @campaign_contact.state, zip: @campaign_contact.zip }
    end

    assert_redirected_to campaign_contact_path(assigns(:campaign_contact))
  end

  test "should show campaign_contact" do
    get :show, id: @campaign_contact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @campaign_contact
    assert_response :success
  end

  test "should update campaign_contact" do
    patch :update, id: @campaign_contact, campaign_contact: { address: @campaign_contact.address, campaign_id: @campaign_contact.campaign_id, city: @campaign_contact.city, description: @campaign_contact.description, email: @campaign_contact.email, name: @campaign_contact.name, phone: @campaign_contact.phone, state: @campaign_contact.state, zip: @campaign_contact.zip }
    assert_redirected_to campaign_contact_path(assigns(:campaign_contact))
  end

  test "should destroy campaign_contact" do
    assert_difference('CampaignContact.count', -1) do
      delete :destroy, id: @campaign_contact
    end

    assert_redirected_to campaign_contacts_path
  end
end
