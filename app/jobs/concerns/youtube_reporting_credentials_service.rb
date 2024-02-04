require 'google/apis/youtube_v3'

module YoutubeReportingCredentialsService
  def youtube_service_credentials
    ya_client = Google::Apis::YoutubeV3::YouTubeService.new
    ya_client.key = ENV['youtube_api_key']
    ya_client
  end
end
