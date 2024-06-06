class ChannelsController < ApplicationController
  before_action :set_channel, only: %i[ show destroy ]

  def index
    @channels = Channel.all
  end

  def show
  end

  def destroy
    @channel.destroy!

    respond_to do |format|
      format.html { redirect_to channels_url, notice: "Channel was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_channel
      @channel = Channel.find(params[:id])
    end
end
