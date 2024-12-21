require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @user2 = users(:two)
  end

  test "should get index" do
    get users_url, as: :json
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { name: @user.name } }, as: :json
    end

    assert_response :created
  end

  test "should not create user without a name" do
    assert_no_difference("User.count") do
      post users_url, params: { user: { id: @user.id } }, as: :json
    end

    assert_response :unprocessable_entity
  end

  test "should show user" do
    get user_url(@user), as: :json
    assert_response :success
  end

  test "should show user's sleeps" do
    get user_sleeps_url(@user), as: :json
    assert_response :success
  end

  test "should show user's feed" do
    get user_feed_url(@user), as: :json
    assert_response :success
  end

  test "should create user's clock in" do
    assert_difference("Sleep.count") do
      post user_clock_in_url(@user), as: :json
    end

    assert_response :created
  end

  test "should not create user's clock in if still sleeping" do
    Sleep.create(user_id: @user.id)
    assert_no_difference("Sleep.count") do
      post user_clock_in_url(@user), as: :json
    end

    assert_response :unprocessable_entity
  end

  test "should clock out user's sleep" do
    Sleep.create(user_id: @user.id)
    patch user_clock_out_url(@user), as: :json
    assert_response :success
  end

  test "should not clock out user if not sleeping" do
    patch user_clock_out_url(@user), as: :json
    assert_response :unprocessable_entity
  end

  test "should follow another user" do
    assert_difference("Connection.count") do
      post user_follow_url(@user, @user2), as: :json
    end

    assert_response :created
  end

  # test "should follow another user that has been followed and unfollowed before" do
  #   Connection.create(follower_id: @user, following_id: @user2, unfollowed_at: Time.now)
  #   puts Connection.count
  #   assert_no_difference("Connection.count") do
  #     post user_follow_url(@user, @user2), as: :json
  #   end
  #   puts Connection.count

  #   assert_response :unprocessable_entity
  # end

  test "should not follow self" do
    assert_no_difference("Connection.count") do
      post user_follow_url(@user, @user), as: :json
    end

    assert_response :unprocessable_entity
  end

  test "should unfollow another user" do
    Connection.create(follower_id: @user.id, following_id: @user2.id)
    patch user_unfollow_url(@user, @user2), as: :json
    assert_response :success
  end

  test "should not unfollow self" do
    patch user_unfollow_url(@user, @user), as: :json
    assert_response :unprocessable_entity
  end

  test "should not unfollow another user that has been already unfollowed" do
    Connection.create(follower_id: @user.id, following_id: @user2.id, unfollowed_at: Time.now)
    patch user_unfollow_url(@user, @user2), as: :json
    assert_response :unprocessable_entity
  end

  test "should update user" do
    patch user_url(@user), params: { user: { name: @user.name } }, as: :json
    assert_response :success
  end

  test "should not update user without a name" do
    patch user_url(@user), params: { user: { name: "" } }, as: :json
    assert_response :unprocessable_entity
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user), as: :json
    end

    assert_response :no_content
  end
end
