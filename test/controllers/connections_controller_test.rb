require "test_helper"

class ConnectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @connection = connections(:one)
  end

  test "should get index" do
    get connections_url, as: :json
    assert_response :success
  end

  test "should create connection" do
    assert_difference("Connection.count") do
      post connections_url, params: { connection: { follower_id: @connection.follower_id, following_id: @connection.following_id, unfollowed_at: @connection.unfollowed_at } }, as: :json
    end

    assert_response :created
  end

  test "should show connection" do
    get connection_url(@connection), as: :json
    assert_response :success
  end

  test "should update connection" do
    patch connection_url(@connection), params: { connection: { follower_id: @connection.follower_id, following_id: @connection.following_id, unfollowed_at: @connection.unfollowed_at } }, as: :json
    assert_response :success
  end

  test "should destroy connection" do
    assert_difference("Connection.count", -1) do
      delete connection_url(@connection), as: :json
    end

    assert_response :no_content
  end
end
