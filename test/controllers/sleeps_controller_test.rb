require "test_helper"

class SleepsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sleep = sleeps(:one)
  end

  test "should get index" do
    get sleeps_url, as: :json
    assert_response :success
  end

  test "should create sleep" do
    assert_difference("Sleep.count") do
      post sleeps_url, params: { sleep: { ended_at: @sleep.ended_at, user_id: @sleep.user_id } }, as: :json
    end

    assert_response :created
  end

  # test "should not create sleep because of invalid ended_at" do
  #   assert_no_difference("Sleep.count") do
  #     post sleeps_url, params: { sleep: { ended_at: @sleep.ended_at-1.month, user_id: @sleep.user_id } }, as: :json
  #   end

  #   assert_response :unprocessable_entity
  # end

  test "should show sleep" do
    get sleep_url(@sleep), as: :json
    assert_response :success
  end

  test "should update sleep" do
    patch sleep_url(@sleep), params: { sleep: { ended_at: @sleep.ended_at, user_id: @sleep.user_id } }, as: :json
    assert_response :success
  end

  test "should not update sleep because of invalid ended_at" do
    patch sleep_url(@sleep), params: { sleep: { ended_at: 1.week.ago, user_id: @sleep.user_id } }, as: :json
    assert_response :unprocessable_entity
  end

  test "should destroy sleep" do
    assert_difference("Sleep.count", -1) do
      delete sleep_url(@sleep), as: :json
    end

    assert_response :no_content
  end
end
