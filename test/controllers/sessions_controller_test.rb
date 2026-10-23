require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "signs in with valid credentials" do
    assert_difference("@user.sessions.count") do
      post session_url, params: { email_address: @user.email_address, password: "password" }
    end

    assert_redirected_to root_url
    assert cookies[:session_id].present?
  end

  test "signs in with a non-normalized email address" do
    post session_url, params: { email_address: "  ONE@Example.com ", password: "password" }

    assert_redirected_to root_url
    assert cookies[:session_id].present?
  end

  test "rejects an invalid password" do
    assert_no_difference("Session.count") do
      post session_url, params: { email_address: @user.email_address, password: "wrong" }
    end

    assert_redirected_to new_session_url(locale: :en)
    assert_equal "Try another email address or password.", flash[:alert]
    assert cookies[:session_id].blank?
  end

  test "rejects an unknown email address" do
    post session_url, params: { email_address: "nobody@example.com", password: "password" }

    assert_redirected_to new_session_url(locale: :en)
    assert cookies[:session_id].blank?
  end

  test "returns to the originally requested page after signing in" do
    get walls_url
    assert_redirected_to new_session_url(locale: :en)

    sign_in_as @user
    assert_redirected_to walls_url
  end

  test "signs out and destroys the session" do
    sign_in_as @user

    assert_difference("Session.count", -1) do
      delete session_url
    end

    assert_redirected_to new_session_url(locale: :en)
    assert cookies[:session_id].blank?

    get walls_url
    assert_redirected_to new_session_url(locale: :en)
  end

  test "sign out requires a session" do
    delete session_url
    assert_redirected_to new_session_url(locale: :en)
  end
end
