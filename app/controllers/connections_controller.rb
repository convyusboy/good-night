class ConnectionsController < ApplicationController
  before_action :set_connection, only: %i[ show update destroy ]

  # GET /connections
  def index
    @connections = Connection.all

    render json: @connections
  end

  # GET /connections/1
  def show
    render json: @connection
  end

  # PATCH/PUT /connections/1
  def update
    if @connection.update(connection_params)
      render json: @connection
    else
      render json: @connection.errors, status: :unprocessable_entity
    end
  end

  # DELETE /connections/1
  def destroy
    @connection.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_connection
      @connection = Connection.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def connection_params
      params.require(:connection).permit(:follower_id, :following_id, :unfollowed_at)
    end
end
