# frozen_string_literal: true

# == Schema Information
#
# Table name: videos
#
#  id             :bigint           not null, primary key
#  comment_count  :bigint
#  description    :text
#  duration       :string
#  favorite_count :bigint
#  like_count     :bigint
#  published_at   :datetime
#  tags           :text
#  title          :text
#  view_count     :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  channel_id     :bigint           not null
#  yt_video_id    :string
#
# Indexes
#
#  index_videos_on_channel_id  (channel_id)
#
# Foreign Keys
#
#  fk_rails_...  (channel_id => channels.id)
#
require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
