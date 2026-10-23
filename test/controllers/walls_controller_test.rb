require "test_helper"

class WallsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wall = walls(:one)
    sign_in_as users(:one)
  end

  test "should get index" do
    get walls_url
    assert_response :success
  end

  test "should get new" do
    get new_wall_url
    assert_response :success
  end

  test "should create wall" do
    assert_difference("Wall.count") do
      post walls_url, params: { wall: { title: @wall.title } }
    end

    assert_redirected_to wall_url(Wall.last, locale: :en)
  end

  test "should show wall" do
    get wall_url(@wall)
    assert_response :success
  end

  test "should get edit" do
    get edit_wall_url(@wall)
    assert_response :success
  end

  test "should update wall" do
    patch wall_url(@wall), params: { wall: { title: @wall.title } }
    assert_redirected_to wall_url(@wall, locale: :en)
  end

  test "should destroy wall" do
    assert_difference("Wall.count", -1) do
      delete wall_url(@wall)
    end

    assert_redirected_to walls_url(locale: :en)
  end

  test "rejects a request without wall params" do
    assert_no_difference("Wall.count") do
      post walls_url, params: { title: "No wrapper" }
    end

    assert_response :bad_request
  end

  test "any signed-in user may edit and delete any wall" do
    sign_out
    sign_in_as users(:two)

    patch wall_url(@wall), params: { wall: { title: "Shared" } }
    assert_equal "Shared", @wall.reload.title

    assert_difference("Wall.count", -1) do
      delete wall_url(@wall)
    end
  end

  test "JSON: lists walls" do
    get walls_url(format: :json)

    assert_response :success
    assert_equal Wall.count, response.parsed_body.size
    assert_equal %w[created_at id title updated_at url], response.parsed_body.first.keys.sort
  end

  test "JSON: creates a wall" do
    assert_difference("Wall.count") do
      post walls_url(format: :json), params: { wall: { title: "From the API" } }
    end

    assert_response :created
    assert_equal "From the API", response.parsed_body["title"]
  end

  test "JSON: updates a wall" do
    patch wall_url(@wall, format: :json), params: { wall: { title: "Renamed" } }

    assert_response :success
    assert_equal "Renamed", @wall.reload.title
  end

  test "JSON: destroys a wall" do
    assert_difference("Wall.count", -1) do
      delete wall_url(@wall, format: :json)
    end

    assert_response :no_content
  end
end

class WallsControllerSignedOutTest < ActionDispatch::IntegrationTest
  setup do
    @wall = walls(:one)
  end

  test "redirects every read action to sign in" do
    [ walls_url, new_wall_url, wall_url(@wall), edit_wall_url(@wall) ].each do |url|
      get url
      assert_redirected_to new_session_url(locale: :en), "expected #{url} to require sign in"
    end
  end

  test "does not create, update or destroy walls" do
    assert_no_difference("Wall.count") do
      post walls_url, params: { wall: { title: "Anonymous" } }
      delete wall_url(@wall)
    end

    patch wall_url(@wall), params: { wall: { title: "Anonymous" } }
    assert_not_equal "Anonymous", @wall.reload.title
  end

  test "JSON requests also require sign in" do
    get walls_url(format: :json)
    assert_response :redirect
  end
end
