class UsersController < ApplicationController
  before_action :set_user, only: %i[ show sleeps feed clock_in clock_out follow unfollow update destroy ]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # GET /users/1/sleeps
  def sleeps
    @sleeps = @user.sleeps
    render json: @sleeps
  end

  # GET /users/1/feed
  def feed
    @sleeps = Sleep.where(user_id: @user.following.ids).recents.finished.order(duration: :desc)
    render json: @sleeps
  end

  # POST /users/1/clock_in
  def clock_in
    @sleep = Sleep.new(user_id: @user.id)
    if @sleep.save
      @sleeps = @user.sleeps
      render json: @sleeps.order(created_at: :desc), status: :created, location: @user
    else
      render json: @sleep.errors, status: :unprocessable_entity
    end
  end

  # PATCH /users/1/clock_out
  def clock_out
    @sleep = @user.sleeps.last
    if @sleep&.ongoing?
      @sleep.ended_at = Time.now
      @sleep.duration = @sleep.ended_at - @sleep.created_at
      @sleep.save
      @sleeps = @user.sleeps.order(created_at: :desc)
      render json: @sleeps, location: @user
    else
      render json: { base: [ "There's no sleep to be clocked out" ] }, status: :unprocessable_entity
    end
  end

  # POST /users/1/follow/2
  def follow
    @connection = Connection.find_or_initialize_by(follower_id: @user.id, following_id: params[:following_id])
    if @connection.follow
      render json: @connection, status: :created, location: @connection
    else
      render json: @connection.errors, status: :unprocessable_entity
    end
  end

  # PATCH /users/1/unfollow/2
  def unfollow
    @connection = @user.following_relationships.active.find_by(following_id: params[:following_id])
    if @connection&.unfollow
      render json: @connection, location: @connection
    else
      render json: { base: [ "Connection not valid" ] }, status: :unprocessable_entity
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name)
    end
end
