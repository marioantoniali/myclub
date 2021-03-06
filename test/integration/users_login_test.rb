require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

    def setup
        @user = users(:one)
    end

    test "login with invalid information (email and password empty)" do
        get login_path
        assert_template 'sessions/new'
        post login_path, params: { session: { email: "", password: "" } }
        assert_template 'sessions/new'
        assert_not flash.empty?
        get root_path
        assert flash.empty?
    end

    test "login with invalid information (password error)" do
        get login_path
        assert_template 'sessions/new'
        log_in_as users(:user_with_bad_password)
        assert_template 'sessions/new'
        assert_not flash.empty?
        get root_path
        assert flash.empty?
    end

    test "login with valid information" do
        get login_path
        assert_template 'sessions/new'
        log_in_as @user
        assert_redirected_to @user
        follow_redirect!
        assert_template 'users/show'
        assert_select "a[href=?]", login_path, count: 0
        assert_select "a[href=?]", logout_path, count: 1
        assert_select "a[href=?]", user_path(@user), count: 1
    end


end
