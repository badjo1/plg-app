require "application_system_test_case"

class LocaleSwitchTest < ApplicationSystemTestCase
  test "switching between English and Dutch keeps the current page" do
    visit who_we_are_path(locale: :en)
    assert_selector "html[lang=en]", visible: false
    within("header nav") { assert_link "Sign in" }

    within("header nav") { click_on "Nederlands" }

    assert_current_path who_we_are_path(locale: :nl)
    assert_selector "html[lang=nl]", visible: false
    within("header nav") { assert_link "Inloggen" }

    within("header nav") { click_on "English" }

    assert_current_path who_we_are_path(locale: :en)
  end

  test "navigation links keep the chosen locale" do
    visit root_path(locale: :nl)
    within("header nav") { click_on I18n.t("global.menu.Events", locale: :nl) }

    assert_current_path events_path(locale: :nl)
    assert_selector "html[lang=nl]", visible: false
  end
end
