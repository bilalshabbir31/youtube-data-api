# frozen_string_literal: true

class AddMetaDataToChannels < ActiveRecord::Migration[7.1]
  def change
    add_column :channels, :description, :string
    add_column :channels, :custom_url, :string
    add_column :channels, :published_at, :datetime
    add_column :channels, :view_count, :bigint
    add_column :channels, :subscriber_count, :bigint
    add_column :channels, :hidden_subscriber_count, :boolean
    add_column :channels, :video_count, :bigint
  end
end
