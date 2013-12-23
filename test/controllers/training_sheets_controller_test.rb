require 'test_helper'

class TrainingSheetsControllerTest < ActionController::TestCase
  setup do
    @training_sheet = training_sheets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:training_sheets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create training_sheet" do
    assert_difference('TrainingSheet.count') do
      post :create, training_sheet: { campaign_id: @training_sheet.campaign_id, man_ac: @training_sheet.man_ac, man_camp_admin: @training_sheet.man_camp_admin, man_camp_chair: @training_sheet.man_camp_chair, man_childs_act: @training_sheet.man_childs_act, man_contact: @training_sheet.man_contact, man_follow_up: @training_sheet.man_follow_up, man_info: @training_sheet.man_info, man_invlvm: @training_sheet.man_invlvm, man_pace_gifts: @training_sheet.man_pace_gifts, man_pastor: @training_sheet.man_pastor, man_prayer: @training_sheet.man_prayer, man_print_comm: @training_sheet.man_print_comm, man_spc_event: @training_sheet.man_spc_event, man_vis_comm: @training_sheet.man_vis_comm, man_youth: @training_sheet.man_youth, print_contact_email: @training_sheet.print_contact_email, print_contact_name: @training_sheet.print_contact_name, print_contact_phone: @training_sheet.print_contact_phone, ts_ac1: @training_sheet.ts_ac1, ts_ac2: @training_sheet.ts_ac2, ts_ac3: @training_sheet.ts_ac3, ts_ct1: @training_sheet.ts_ct1, ts_ct2: @training_sheet.ts_ct2, ts_ct3: @training_sheet.ts_ct3, ts_ct4: @training_sheet.ts_ct4, ts_ct5: @training_sheet.ts_ct5, ts_ct6: @training_sheet.ts_ct6, ts_ct7: @training_sheet.ts_ct7, ts_it1: @training_sheet.ts_it1, ts_it2: @training_sheet.ts_it2 }
    end

    assert_redirected_to training_sheet_path(assigns(:training_sheet))
  end

  test "should show training_sheet" do
    get :show, id: @training_sheet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @training_sheet
    assert_response :success
  end

  test "should update training_sheet" do
    patch :update, id: @training_sheet, training_sheet: { campaign_id: @training_sheet.campaign_id, man_ac: @training_sheet.man_ac, man_camp_admin: @training_sheet.man_camp_admin, man_camp_chair: @training_sheet.man_camp_chair, man_childs_act: @training_sheet.man_childs_act, man_contact: @training_sheet.man_contact, man_follow_up: @training_sheet.man_follow_up, man_info: @training_sheet.man_info, man_invlvm: @training_sheet.man_invlvm, man_pace_gifts: @training_sheet.man_pace_gifts, man_pastor: @training_sheet.man_pastor, man_prayer: @training_sheet.man_prayer, man_print_comm: @training_sheet.man_print_comm, man_spc_event: @training_sheet.man_spc_event, man_vis_comm: @training_sheet.man_vis_comm, man_youth: @training_sheet.man_youth, print_contact_email: @training_sheet.print_contact_email, print_contact_name: @training_sheet.print_contact_name, print_contact_phone: @training_sheet.print_contact_phone, ts_ac1: @training_sheet.ts_ac1, ts_ac2: @training_sheet.ts_ac2, ts_ac3: @training_sheet.ts_ac3, ts_ct1: @training_sheet.ts_ct1, ts_ct2: @training_sheet.ts_ct2, ts_ct3: @training_sheet.ts_ct3, ts_ct4: @training_sheet.ts_ct4, ts_ct5: @training_sheet.ts_ct5, ts_ct6: @training_sheet.ts_ct6, ts_ct7: @training_sheet.ts_ct7, ts_it1: @training_sheet.ts_it1, ts_it2: @training_sheet.ts_it2 }
    assert_redirected_to training_sheet_path(assigns(:training_sheet))
  end

  test "should destroy training_sheet" do
    assert_difference('TrainingSheet.count', -1) do
      delete :destroy, id: @training_sheet
    end

    assert_redirected_to training_sheets_path
  end
end
