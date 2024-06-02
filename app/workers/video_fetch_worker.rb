# frozen_string_literal: true

require 'google/apis/youtube_v3'

class VideoFetchWorker
  include Sidekiq::Worker
  include YoutubeReportingCredentialsService

  def perform(channel_id)
    channel = Channel.find(channel_id)
    video_ids = fetch_channel_data(channel.yt_channel_id)
    enqueue_videos(video_ids, channel.id)
  end

  private

    def fetch_channel_data(yt_channel_id) # rubocop:disable Metrics/MethodLength
      ya_client = youtube_service_credentials
      video_ids = []
      next_page_token = nil
      loop do
        response = ya_client.list_searches('snippet', channel_id: yt_channel_id, max_results: 50, type: 'video',
                                                      page_token: next_page_token)
        response_ids = response.items.map { |item| item&.id&.video_id }.compact
        video_ids += response_ids
        next_page_token = response.next_page_token
        break unless next_page_token.present?
      end
      video_ids
    end

    def enqueue_videos(video_ids, channel_id)
      array_of_args = video_ids.map { |id| [id, channel_id] }
      Sidekiq::Client.push_bulk('class' => VideoDataFetchWorker, 'args' => array_of_args)
    end
end
