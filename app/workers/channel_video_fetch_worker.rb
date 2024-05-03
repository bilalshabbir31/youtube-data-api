# frozen_string_literal: true

require 'google/apis/youtube_v3'
class ChannelVideoFetchWorker
  include Sidekiq::Worker
  include YoutubeReportingCredentialsService

  def perform(yt_channel_id)
    channel, video_ids = fetch_channel_data(yt_channel_id)
    enqueue_videos(video_ids, channel.id)
  end

  private

    def fetch_channel_data(yt_channel_id)
      ya_client = youtube_service_credentials
      video_ids = []
      channel_title = nil
      next_page_token = nil
      loop do
        response = ya_client.list_searches('snippet', channel_id: yt_channel_id, max_results: 50, type: 'video',
                                                      page_token: next_page_token)
        channel_title ||= response&.items&.first&.snippet&.channel_title
        response_ids = response.items.map { |item| item.id.video_id }.compact
        video_ids += response_ids
        next_page_token = response.next_page_token
        break unless next_page_token.present?
      end
      channel = Channel.find_or_initialize_by(yt_channel_id:)
      channel.name = channel_title
      channel.save if channel.changed?
      [channel, video_ids]
    end

    def enqueue_videos(video_ids, channel_id)
      array_of_args = video_ids.map { |id| [id, channel_id] }
      Sidekiq::Client.push_bulk('class' => VideoDataFetchWorker, 'args' => array_of_args)
    end
end
