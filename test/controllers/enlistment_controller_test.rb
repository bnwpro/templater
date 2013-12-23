require 'test_helper'

class EnlistmentControllerTest < ActionController::TestCase
  test "should get ac_enlist:integer" do
    get :ac_enlist:integer
    assert_response :success
  end

  test "should get childs_act_enlist:integer" do
    get :childs_act_enlist:integer
    assert_response :success
  end

  test "should get spc_event_enlist:integer" do
    get :spc_event_enlist:integer
    assert_response :success
  end

  test "should get contact_enlist:integer" do
    get :contact_enlist:integer
    assert_response :success
  end

  test "should get contact_each_enlist:integer" do
    get :contact_each_enlist:integer
    assert_response :success
  end

  test "should get info_enlist:integer" do
    get :info_enlist:integer
    assert_response :success
  end

end
