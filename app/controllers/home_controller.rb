# frozen_string_literal: true

class HomeController < ApplicationController
  def index; end

  def fetch_channel_videos
    yt_channel_id = params[:yt_channel_id]
    ChannelFetchWorker.perform_async(yt_channel_id)
    flash[:notice] = "Fetching Channel Data: #{yt_channel_id}"
    redirect_to root_path
  end
end
