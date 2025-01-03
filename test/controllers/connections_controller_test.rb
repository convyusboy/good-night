require "test_helper"

class ConnectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @connection = connections(:one)
  end

  test "should get index" do
    get connections_url, as: :json
    assert_response :success
  end

  test "should show connection" do
    get connection_url(@connection), as: :json
    assert_response :success
  end

  test "should update connection" do
    patch connection_url(@connection), params: { connection: { follower_id: @connection.follower_id, following_id: @connection.following_id } }, as: :json
    assert_response :success
  end

  test "should not update connection because of invalid id" do
    patch connection_url(@connection), params: { connection: { follower_id: @connection.follower_id, following_id: 0 } }, as: :json
    assert_response :unprocessable_entity
  end

  test "should destroy connection" do
    assert_difference("Connection.count", -1) do
      delete connection_url(@connection), as: :json
    end

    assert_response :no_content
  end
end
