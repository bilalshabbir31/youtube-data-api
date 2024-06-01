# frozen_string_literal: true

class AddMetaDataToChannels < ActiveRecord::Migration[7.1]
  def change
    add_column :channels, :description, :string
    add_column :channel, :custom_url, :string
    add_column :channel, :published_at, :datetime
    add_column :channel, :viewCount, :bigint
    add_column :channel, :subscriberCount, :bigint
    add_column :channel, :hiddenSubscriberCount, :boolean
    add_column :channel, :videoCount, :bigint
  end
end
