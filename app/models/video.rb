# frozen_string_literal: true

# == Schema Information
#
# Table name: videos
#
#  id           :bigint           not null, primary key
#  description  :text
#  duration     :string
#  published_at :datetime
#  tags         :text
#  title        :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  channel_id   :bigint           not null
#  yt_video_id  :string
#
# Indexes
#
#  index_videos_on_channel_id  (channel_id)
#
# Foreign Keys
#
#  fk_rails_...  (channel_id => channels.id)
#
class Video < ApplicationRecord
  belongs_to :channel
end
