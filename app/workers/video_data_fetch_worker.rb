# frozen_string_literal: true

require 'google/apis/youtube_v3'
class VideoDataFetchWorker
  include Sidekiq::Worker
  include YoutubeReportingCredentialsService

  def perform(video_id, channel_id)
    ya_client = youtube_service_credentials
    response = ya_client.list_videos('snippet,contentDetails', id: video_id)
    record = build_record(video_id, response, channel_id)
    Video.find_or_create_by(yt_video_id: video_id).update(record)
  end

  private

    def build_record(video_id, response, channel_id)
      {
        yt_video_id: video_id,
        title: response.items.first.snippet.title,
        description: response.items.first.snippet.description,
        duration: response.items.first.content_details.duration,
        tags: response.items.first.snippet.tags,
        published_at: response.items.first.snippet.published_at,
        channel_id:
      }
    end
end
