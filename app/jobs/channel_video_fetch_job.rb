# frozen_string_literal: true

require 'google/apis/youtube_v3'
class ChannelVideoFetchJob < ApplicationJob
  include YoutubeReportingCredentialsService

  def perform(yt_channel_id)
    ya_client = youtube_service_credentials
    video_ids = []
    channel_title = nil
    next_page_token = nil
    loop do
      response = ya_client.list_searches('snippet', channel_id: yt_channel_id, max_results: 50, type: 'video',
                                                    page_token: next_page_token)
      channel_title = response.items.first.snippet.channel_title
      response_ids = response.items.map { |item| item.id.video_id }.compact
      video_ids += response_ids
      next_page_token = response.next_page_token
      break if next_page_token.nil?
    end
    channel = Channel.find_or_initialize_by(yt_channel_id:)
    channel.name = channel_title
    channel.save if channel.changed?
    video_fetch_jobs = video_ids.map do |video_id|
      VideoDataFetchJob.new(video_id, channel.id)
    end
    ActiveJob.perform_all_later(video_fetch_jobs)
  end
end
