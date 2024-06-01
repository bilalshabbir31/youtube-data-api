# frozen_string_literal: true

require 'google/apis/youtube_v3'

class VideoDataFetchWorker
  include Sidekiq::Worker
  include YoutubeReportingCredentialsService

  def perform(video_id, channel_id)
    ya_client = youtube_service_credentials
    response = ya_client.list_videos('snippet,contentDetails,statistics', id: video_id)
    record = build_record(video_id, response, channel_id)
    Video.find_or_create_by(yt_video_id: video_id).update(record)
  end

  private

    def build_record(video_id, response, channel_id)
      items = response.items.first
      statistics = items.statistics
      {
        yt_video_id: video_id,
        title: items&.snippet&.title,
        description: items&.snippet&.description,
        duration: items&.content_details&.duration,
        tags: items&.snippet&.tags,
        published_at: items&.snippet&.published_at,
        comment_count: statistics.comment_count,
        favorite_count: statistics.favorite_count,
        like_count: statistics.like_count,
        view_count: statistics.view_count,
        channel_id:
      }
    end
end
