require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "sends reset instructions to an existing user" do
    assert_enqueued_email_with PasswordsMailer, :reset, args: [ @user ] do
      post passwords_url, params: { email_address: @user.email_address }
    end

    assert_redirected_to new_session_url(locale: :en)
  end

  test "does not reveal whether an email address exists" do
    assert_no_enqueued_emails do
      post passwords_url, params: { email_address: "nobody@example.com" }
    end

    assert_redirected_to new_session_url(locale: :en)
    assert_equal "Password reset instructions sent (if user with that email address exists).", flash[:notice]
  end

  test "shows the reset form for a valid token" do
    get edit_password_url(@user.password_reset_token)
    assert_response :success
  end

  test "rejects an invalid token" do
    get edit_password_url("invalid")
    assert_redirected_to new_password_url(locale: :en)

    put password_url("invalid"), params: { password: "newpass123", password_confirmation: "newpass123" }
    assert_redirected_to new_password_url(locale: :en)
    assert @user.reload.authenticate("password")
  end

  test "resets the password with a valid token" do
    put password_url(@user.password_reset_token), params: { password: "newpass123", password_confirmation: "newpass123" }

    assert_redirected_to new_session_url(locale: :en)
    @user.reload
    assert @user.authenticate("newpass123")
    assert_not @user.authenticate("password")
  end

  test "keeps the password when the confirmation does not match" do
    token = @user.password_reset_token
    put password_url(token), params: { password: "newpass123", password_confirmation: "other" }

    assert_redirected_to edit_password_url(token, locale: :en)
    assert @user.reload.authenticate("password")
  end

  test "a token cannot be reused after the password changed" do
    token = @user.password_reset_token
    put password_url(token), params: { password: "newpass123", password_confirmation: "newpass123" }

    get edit_password_url(token)
    assert_redirected_to new_password_url(locale: :en)
  end
end
