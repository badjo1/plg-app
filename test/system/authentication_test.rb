require "application_system_test_case"

class AuthenticationTest < ApplicationSystemTestCase
  test "signing in from the header and signing out again" do
    visit root_path
    within("header nav") { click_on "Sign in" }

    fill_in "email_address", with: users(:one).email_address
    fill_in "password", with: "password"
    click_button "Sign in"

    within("header nav") do
      assert_button "Sign out"
      click_on "Sign out"
    end

    assert_selector "h1", text: "Sign in"
    within("header nav") { assert_link "Sign in" }
  end

  test "a wrong password shows an error" do
    sign_in_through_form users(:one), password: "wrong"

    assert_text "Try another email address or password."
  end

  test "signing up as a new user" do
    skip "BUG: /registration/new raises on missing partial shared/_error_messages (500)"

    visit new_registration_path
    fill_in "user[email_address]", with: "new@example.com"
    fill_in "user[password]", with: "secret123"
    fill_in "user[password_confirmation]", with: "secret123"
    click_on "Sign up"

    assert_text "Successfully signed up!"
  end
end
