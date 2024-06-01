# frozen_string_literal: true

require 'google/apis/youtube_v3'

class ChannelFetchWorker
  include Sidekiq::Worker
  include YoutubeReportingCredentialsService

  def perform(yt_channel_id)
    ya_client = youtube_service_credentials
    response = ya_client.list_channels('snippet,contentDetails,statistics, status', id: yt_channel_id)
    channel = create_channel(response)
    VideoFetchWorker.perform_async(channel.id)
  end

  private

    def create_channel(response)
      items = response&.items&.first
      statistics = items&.statistics
      channel = Channel.find_or_initialize_by(yt_channel_id: items.id)
      channel.name = items.snippet.title
      channel.description = items.snippet&.description
      channel.custom_url = items.snippet&.custom_url
      channel.published_at = items.snippet&.published_at
      channel.hidden_subscriber_count = statistics&.hidden_subscriber_count
      channel.subscriber_count = statistics&.subscriber_count
      channel.video_count = statistics&.video_count
      channel.view_count = statistics&.view_count
      channel.save if channel.changed?
      channel
    end
end
