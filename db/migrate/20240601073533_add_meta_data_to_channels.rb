# frozen_string_literal: true

class AddMetaDataToChannels < ActiveRecord::Migration[7.1]
  def change
    add_column :channels, :description, :string
    add_column :channels, :custom_url, :string
    add_column :channels, :published_at, :datetime
    add_column :channels, :viewCount, :bigint
    add_column :channels, :subscriberCount, :bigint
    add_column :channels, :hiddenSubscriberCount, :boolean
    add_column :channels, :videoCount, :bigint
  end
end
