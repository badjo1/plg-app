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
    visit walls_path
    click_on "New wall"

    fill_in "Title", with: "Copernicus wall"
    click_on "Create Wall"
    assert_text "Wall was successfully created"

    visit walls_path
    within("#walls") do
      within(:xpath, ".//div[p[contains(., 'Copernicus wall')]]") { click_on "Edit this wall" }
    end

    fill_in "Title", with: "Copernicus wall, phase 2"
    click_on "Update Wall"
    assert_text "Wall was successfully updated"

    visit walls_path
    assert_text "Copernicus wall, phase 2"
  end
end
