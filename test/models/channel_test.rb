# frozen_string_literal: true

# == Schema Information
#
# Table name: channels
#
#  id                      :bigint           not null, primary key
#  custom_url              :string
#  description             :string
#  hidden_subscriber_count :boolean
#  name                    :string
#  published_at            :datetime
#  subscriber_count        :bigint
#  video_count             :bigint
#  view_count              :bigint
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  yt_channel_id           :string
#
require 'test_helper'

class ChannelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
