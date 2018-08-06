require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include SessionsHelper

  def setup
    @user = users(:one)
    @other_user = users(:two)
  end


  test "should access to private" do
    if log_in_as(@user)
      get index_url
      assert_response :success

    else
      get login_url
      assert_response :success
    end
  end


  test "should access users infos if logged" do
    if log_in_as(@user)
    get user_path(@user.id)
    assert_response :success

  else
    assert_template 'sessions/new'
    assert_not flash.empty?
       get root_path
       assert flash.empty?
  end




  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
    assert_not flash.empty?
  end


end
