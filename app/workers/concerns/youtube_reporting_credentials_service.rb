# frozen_string_literal: true

require 'google/apis/youtube_v3'

module YoutubeReportingCredentialsService
  def youtube_service_credentials
    Google::Apis::YoutubeV3::YouTubeService.new.tap do |ya_client|
      ya_client.key = ENV['youtube_api_key']
    end
  end
end
