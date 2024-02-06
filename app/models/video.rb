# frozen_string_literal: true

# == Schema Information
#
# Table name: videos
#
#  id           :bigint           not null, primary key
#  yt_video_id  :string
#  title        :text
#  description  :text
#  duration     :string
#  tags         :text
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  channel_id   :bigint           not null
#
class Video < ApplicationRecord
  belongs_to :channel
end
