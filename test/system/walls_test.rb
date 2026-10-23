require "application_system_test_case"

class WallsTest < ApplicationSystemTestCase
  setup do
    @wall = walls(:one)
  end

  test "visiting walls requires signing in and returns to walls afterwards" do
    visit walls_path
    assert_selector "h1", text: "Sign in"

    fill_in "email_address", with: users(:one).email_address
    fill_in "password", with: "password"
    click_button "Sign in"

    assert_selector "h1", text: "Walls"
  end

  test "creating and editing a wall" do
    sign_in_through_form users(:one)
    within("header nav") { assert_button "Sign out" }

    visit walls_path
    assert_selector "h1", text: "Walls"
    click_on "New wall"

    assert_selector "h1", text: "New wall"
    fill_in "Title", with: "Copernicus wall"
    click_on "Create Wall"
    assert_selector "#notice", text: "Wall was successfully created"

    visit walls_path
    assert_selector "h1", text: "Walls"
    within("#walls") do
      within(:xpath, ".//div[p[contains(., 'Copernicus wall')]]") { click_on "Edit this wall" }
    end

    assert_selector "h1", text: "Editing wall"
    fill_in "Title", with: "Copernicus wall, phase 2"
    click_on "Update Wall"
    assert_selector "#notice", text: "Wall was successfully updated"

    visit walls_path
    assert_selector "#walls", text: "Copernicus wall, phase 2"
  end
end
