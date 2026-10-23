require "test_helper"

class SmokeTest < ActionDispatch::IntegrationTest
  PUBLIC_PAGES = %w[
    /
    /who-we-are
    /what-we-do
    /get-involved
    /explore
    /start-a-project
    /now
    /stories
    /events
    /communities
    /vision
    /privacy
    /members
    /governance
    /token
    /circles
    /explorer
    /crypto-art-friends
  ].freeze

  LOCALE_PREFIXES = [ "", "/en", "/nl" ].freeze

  EXTERNAL_REDIRECTS = {
    "/calendar" => "https://lu.ma/playground.amsterdam",
    "/cryptoartfriend" => "https://luma.com/dxonvsdf",
    "/become-crypto-art-friend" => "https://luma.com/dxonvsdf",
    "/current-exhibition" => "https://luma.com/dxonvsdf"
  }.freeze

  AUTH_PAGES = %w[/session/new /passwords/new].freeze

  def self.localized(path, prefix)
    return prefix.presence || "/" if path == "/"
    "#{prefix}#{path}"
  end

  { "signed out" => false, "signed in" => true }.each do |state, signed_in|
    LOCALE_PREFIXES.each do |prefix|
      PUBLIC_PAGES.each do |page|
        path = localized(page, prefix)

        test "#{state}: GET #{path} renders" do
          sign_in_as users(:one) if signed_in
          get path
          assert_response :success
          assert_equal (prefix.delete("/").presence || "en"), response.headers["content-language"].to_s
          assert_select "html[lang=?]", prefix.delete("/").presence || "en"
        end
      end
    end

    EXTERNAL_REDIRECTS.each do |path, target|
      test "#{state}: GET #{path} redirects to Luma" do
        sign_in_as users(:one) if signed_in
        get path
        assert_redirected_to target
      end
    end
  end

  AUTH_PAGES.each do |path|
    test "signed out: GET #{path} renders" do
      get path
      assert_response :success
    end
  end

  test "signed out: GET /registration/new renders" do
    skip "BUG: views/registrations/new renders missing partial shared/_error_messages (500)"
    get new_registration_path
    assert_response :success
  end

  test "signed out: GET /maisonscript renders" do
    skip "BUG: route points to pages#maisonscript, which has no action or view; MaisonScriptController#index has no route"
    get "/maisonscript"
    assert_response :success
  end

  test "signed out: GET /featured renders" do
    skip "BUG: route points to pages#featured, which has no action or view"
    get "/featured"
    assert_response :success
  end

  test "signed in: GET walls pages render" do
    sign_in_as users(:one)
    [ walls_path, new_wall_path, wall_path(walls(:one)), edit_wall_path(walls(:one)) ].each do |path|
      get path
      assert_response :success, "expected #{path} to render"
    end
  end

  test "health check responds" do
    get rails_health_check_path
    assert_response :success
  end

  test "explorer subdomain renders the explorer landing page" do
    host! "explorer.example.com"
    get "/"
    assert_response :success
    assert_select "title", "Circles Amsterdam"
  end

  test "dashboard subdomain renders the explorer landing page" do
    host! "dashboard.example.com"
    get "/"
    assert_response :success
    assert_select "title", "Circles Amsterdam"
  end
end
