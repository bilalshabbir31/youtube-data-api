# frozen_string_literal: true

# == Schema Information
#
# Table name: channels
#
#  id            :bigint           not null, primary key
#  name          :string
#  yt_channel_id :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Channel < ApplicationRecord
  has_many :videos
end
