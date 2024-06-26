# frozen_string_literal: true

class VideosController < ApplicationController
  before_action :set_video, only: %i[show destroy]

  def index
    records = Video.includes(:channel).where(channel: { id: params[:channel_id] })
    @pagy, @videos = pagy(records)
  end

  def show; end

  def destroy
    @video.destroy!

    respond_to do |format|
      format.html { redirect_to channel_video_url(params[:channel_id]), notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
      format.turbo_stream
    end
  end

  private

    def set_video
      @video = Video.find(params[:id])
    end
end
